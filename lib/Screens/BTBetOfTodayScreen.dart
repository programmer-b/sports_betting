import 'package:sports_betting/Commons/BTColors.dart';
import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:sports_betting/Components/BTTopMenuLayout.dart';
import 'package:sports_betting/Model/BTAllTipsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

import '../Components/BTBackgroundComponent.dart';
import '../Components/BTDrawerComponent.dart';
import 'package:sports_betting/Commons/BTEnums.dart';
import '../Provider/BTProvider.dart';
import '../Utils/BTAdhelper.dart';

class BTBetOfTodayScreen extends StatefulWidget {
  const BTBetOfTodayScreen({Key? key}) : super(key: key);

  @override
  State<BTBetOfTodayScreen> createState() => _BTBetOfTodayScreenState();
}

class _BTBetOfTodayScreenState extends State<BTBetOfTodayScreen> {
  final width = double.infinity;

  Map<String, String> getYearMonthAndDay(index) {
    dynamic month =
        dates[index]?.lastChars(10).substring(0, 5).lastChars(2).toInt();
    int monthIndex = month != null ? month - 1 : 0;
    month = months[monthIndex];
    dynamic year = dates[index]?.lastChars(4) ?? '2022';
    dynamic day = dates[index]?.lastChars(10).substring(0, 2);
    dynamic dayPostfix = "TH";
    switch (day.toString().lastChars(1)) {
      case '1':
        if (day != '11') {
          dayPostfix = 'ST';
        }
        break;
      case '2':
        if (day != '12') {
          dayPostfix = 'ND';
        }
        break;
      case '3':
        if (day != '13') {
          dayPostfix = 'RD';
        }
        break;
      default:
        dayPostfix = 'TH';
    }
    return {
      "day": day.toString(),
      "month": month.toString().toUpperCase(),
      "year": year.toString(),
      "dayPostfix": dayPostfix
    };
  }

  Map<String, dynamic> gameStatistics(index) {
    var gamesPlayed = time[index].length - 3;
    int gamesWon = 0;
    int gamesLost = 0;
    int iterations = 0;
    while (iterations < gamesPlayed) {
      if (resultColorCodes[index][iterations] == '#008000') {
        gamesWon++;
      } else {
        gamesLost++;
      }
      iterations++;
    }
    dynamic averageOfWin = 0.0;
    averageOfWin = ((gamesWon / gamesPlayed) * 100).toStringAsFixed(2);
    return {
      "played": gamesPlayed,
      "won": gamesWon,
      "lost": gamesLost,
      "averageOfWin": averageOfWin
    };
  }

  List<DataColumn> columns(table) => [
        DataColumn(
            label: SizedBox(
          width: 70,
          child: Text(
            'DATE',
            style: boldTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataColumn(
            label: Text(
          'MATCH',
          style: boldTextStyle(size: 12, color: btPrimaryTextColor),
        )),
        DataColumn(
            label: Text(
          'TIPS',
          style: boldTextStyle(size: 12, color: btPrimaryTextColor),
        )),
        DataColumn(
            label: Text(
          'ODDS',
          style: boldTextStyle(size: 12, color: btPrimaryTextColor),
        )),
        DataColumn(
            label: Text(
          'F/T',
          style: boldTextStyle(size: 12, color: btPrimaryTextColor),
        ))
      ];
  List<DataCell> cells(table, row) => [
        DataCell(SizedBox(
          width: 70,
          child: Text(
            dates[table]?.lastChars(10).replaceAll(".", "/") ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataCell(SizedBox(
          width: 80,
          child: Text(
            teams[table][row] ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataCell(Text(
          tips[table][row] ?? "null",
          style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
        ).center()),
        DataCell(SizedBox(
          width: 30,
          child: Text(
            odds[table][row] ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataCell(Container(
          color: resultColorCodes[table][row]?.toColor(),
          padding: EdgeInsets.zero,
          height: 34,
          width: 60,
          child: Text(
            results[table][row] ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ).center(),
        ))
      ];
  @override
  void initState() {
    super.initState();
    createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BTProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          bottomNavigationBar: Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 52,
                  child: AdWidget(ad: bannerAd!))
              .visible(bannerAd != null && provider.btLoadSuccess),
          appBar: AppBar(
            title: Text(provider.currentScreenTitle),
            actions: [
              IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    await FlutterShare.share(
                        title: 'Share betting tips app',
                        text:
                            "https://play.google.com/store/apps/details?id=com.dantech.bettingtips");
                  })
            ],
          ),
          body: BTLoadingComponent(
              child: BTBackgroundComponent(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const BTTopMenuLayout(),
                    for (int table = 1; table < dates.length; table++)
                      Column(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text:
                                    '${getYearMonthAndDay(table)["month"]} , ${getYearMonthAndDay(table)["day"]} ${getYearMonthAndDay(table)["dayPostfix"]} - ${getYearMonthAndDay(table)['year']} ',
                                style: boldTextStyle(
                                    color: btTableHeaderTextColor)),
                            TextSpan(
                                text:
                                    'WE PLAY ${gameStatistics(table)['played']} ',
                                style:
                                    boldTextStyle(color: btPrimaryTextColor)),
                            TextSpan(
                                text: 'GAMES ',
                                style: boldTextStyle(color: Colors.cyan[400])),
                            TextSpan(
                                text: 'WE ',
                                style:
                                    boldTextStyle(color: btPrimaryTextColor)),
                            TextSpan(
                                text: 'WON ${gameStatistics(table)['won']} ',
                                style: boldTextStyle(color: btHeaderDateColor)),
                            TextSpan(
                                text: 'AND ',
                                style:
                                    boldTextStyle(color: btPrimaryTextColor)),
                            TextSpan(
                                text: 'LOSE ${gameStatistics(table)['lost']} ',
                                style: boldTextStyle(
                                    color: Colors.deepOrange[700])),
                            TextSpan(
                                text: 'WITH AVERAGE OF WIN ',
                                style:
                                    boldTextStyle(color: btPrimaryTextColor)),
                            TextSpan(
                                text:
                                    '${gameStatistics(table)['averageOfWin']} ',
                                style: boldTextStyle(
                                    color: Colors.deepOrange[700])),
                            TextSpan(
                                text: '%',
                                style: boldTextStyle(color: btHeaderDateColor))
                          ])).paddingSymmetric(horizontal: 20, vertical: 10),
                          DataTable(
                                  columnSpacing: 25,
                                  dataRowHeight: 34,
                                  headingRowHeight: 34,
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => btBackgroundBlueColor),
                                  border: TableBorder.all(
                                    color: Colors.grey,
                                  ),
                                  columns: columns(table),
                                  rows: List<DataRow>.generate(
                                      time[table].length,
                                      (index) =>
                                          DataRow(cells: cells(table, index))))
                              .paddingAll(8),
                        ],
                      )
                  ],
                )),
          )),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
