// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:sports_betting/Commons/BTMenu.dart';
import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Model/BTAllTipsModel.dart';
import 'package:sports_betting/Screens/BTBettingTipsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:html/parser.dart';
import '../Commons/BTInfo.dart';
import '../Utils/BTAdhelper.dart';

class BTProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  String _currentScreenTitle = menu[0]['name'];
  String get currentScreenTitle => _currentScreenTitle;

  Future<void> init() async {
    _currentScreenTitle = menu[0]['name'];
    _currentIndex = 0;
  }

  Future<void> updateScreen(context,
      {required final int index,
      PageRouteAnimation? pageRouteAnimation =
          PageRouteAnimation.Slide}) async {
    showInterstitialAd();
    var menus = List.from(menu)..addAll(info);
    log('NEW MENU LENGTH: ${menus.length}');

    _currentIndex = index;
    _currentScreenTitle = menus[index]['name'] ?? "BETTING TIPS";
    notifyListeners();

    await 50.milliseconds.delay;

    Widget? newScreen = menus[index]['route'] ?? const BTBettingTipsScreen();
    log('NAVIGATING TO THIS INDEX: $index');
    newScreen.launch(context,
        isNewTask: true, pageRouteAnimation: pageRouteAnimation);
    createInterstitialAd();
  }

  bool _btLoadSuccess = false;
  bool get btLoadSuccess => _btLoadSuccess;

  bool _btLoading = true;
  bool get btLoading => _btLoading;

  String _btConnectionErrorMessage = btUnknownError;
  String get btConnectionErrorMessage => _btConnectionErrorMessage;

  void _dataInit() {
    _btLoadSuccess = false;
    _btLoading = true;
    notifyListeners();
  }

  Future<void> btLoadAndStructureData() async {
    createInterstitialAd();
    await 200.milliseconds.delay;
    _dataInit();
    final webData = await btGetDataFromNetwork(uri: Uri.parse(btBaseUrl));
    var document = parse(webData.body);

    var tableData =
        document.getElementsByClassName('width100 first last')[0].children;

    var numberOfTables = tableData.length;

    int table = 0;

    while (table < numberOfTables) {
      var rowData = tableData[table].getElementsByTagName('tr');
      int row = 1;
      var numberOfRows = rowData.length - 3;

      dates.insert(
          table,
          tableData[table]
                  .getElementsByClassName('title')[0]
                  .getElementsByTagName('a')[0]
                  .attributes['title'] ??
              "");
      time.insert(table, []);
      flagUrls.insert(table, []);
      countries.insert(table, []);
      sports.insert(table, []);
      competitions.insert(table, []);
      teams.insert(table, []);
      tips.insert(table, []);
      odds.insert(table, []);
      results.insert(table, []);
      resultColorCodes.insert(table, []);

      while (row < numberOfRows) {
        var columnData = rowData[row].getElementsByTagName('td');
        int column = 0;
        var numberOfColumns = columnData.length;

        int currentRow = row - 1;

        while (column < numberOfColumns) {
          switch (column) {
            case 0:
              time[table].insert(currentRow,
                  columnData[0].getElementsByTagName('strong')[0].text);
              break;
            case 1:
              flagUrls[table].insert(
                  currentRow,
                  columnData[1]
                          .getElementsByTagName('img')[0]
                          .attributes['src'] ??
                      "");

              break;
            case 2:
              countries[table].insert(currentRow,
                  columnData[2].getElementsByTagName('strong')[0].text);

              break;
            case 3:
              sports[table].insert(
                  currentRow,
                  columnData[3]
                          .getElementsByTagName('img')[0]
                          .attributes['alt'] ??
                      "");

              break;
            case 4:
              competitions[table].insert(currentRow,
                  columnData[4].getElementsByTagName('strong')[0].text);

              break;
            case 5:
              teams[table].insert(currentRow,
                  columnData[5].getElementsByTagName('strong')[0].text);
              break;
            case 6:
              tips[table].insert(currentRow,
                  columnData[6].getElementsByTagName('strong')[0].text);
              break;
            case 7:
              odds[table].insert(currentRow,
                  columnData[7].getElementsByTagName('strong')[0].text);
              break;
            case 8:
              resultColorCodes[table].insert(
                  currentRow,
                  columnData[8]
                          .getElementsByTagName('span')[0]
                          .attributes['style']
                          ?.replaceAll("color: ", "")
                          .replaceAll(';', '') ??
                      "#000000");
              results[table].insert(currentRow,
                  columnData[8].getElementsByTagName('strong')[0].text);
              break;
          }
          column++;
        }
        row++;
      }
      table++;
    }
    notifyListeners();
  }

  Future<Response> btGetDataFromNetwork({required Uri uri}) async {
    try {
      final data = await http.get(uri).timeout(const Duration(seconds: 300),
          onTimeout: () =>
              throw TimeoutException('Can\'t connect in 45 seconds.'));
      if (data.statusCode == 200) {
        _btLoadSuccess = true;
        _btLoading = false;
        notifyListeners();
        return data;
      } else {
        _btLoading = false;
        notifyListeners();
        throw Exception();
      }
    } on TimeoutException {
      _btConnectionErrorMessage = btConnectionTimeoutError;
      _btLoading = false;
      notifyListeners();
      rethrow;
    } on SocketException {
      _btConnectionErrorMessage = btSocketExceptionError;
      _btLoading = false;
      notifyListeners();
      rethrow;
    } catch (e) {
      _btLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
