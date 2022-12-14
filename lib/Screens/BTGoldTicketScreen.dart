import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:sports_betting/Components/BTTopMenuLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/BTColors.dart';
import '../Components/BTBackgroundComponent.dart';
import '../Components/BTDrawerComponent.dart';
import '../Model/BTAllTipsModel.dart';
import '../Provider/BTProvider.dart';
import 'package:sports_betting/Commons/BTEnums.dart';

import '../Utils/BTAdhelper.dart';

class BTGoldTicketScreen extends StatefulWidget {
  const BTGoldTicketScreen({Key? key}) : super(key: key);

  @override
  State<BTGoldTicketScreen> createState() => _BTGoldTicketScreenState();
}

class _BTGoldTicketScreenState extends State<BTGoldTicketScreen> {
  int generateRow(table, row) {
    var num = time[table].length / 2;
    switch (row) {
      case 0:
        return 3;
      case 1:
        return num.ceil();
      case 2:
        return time[table].length - 5;
      default:
        return 0;
    }
  }

  List<DataColumn> columns(table) => [
        DataColumn(
            label: SizedBox(
          child: Text(
            'DATE',
            style: boldTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataColumn(
            label: SizedBox(
          child: Text(
            'COUNTRY',
            style: boldTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataColumn(
            label: SizedBox(
          child: Text(
            'MATCH',
            style: boldTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataColumn(
            label: SizedBox(
          child: Text(
            'TIPS',
            style: boldTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataColumn(
            label: SizedBox(
          child: Text(
            'ODDS',
            style: boldTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataColumn(
            label: SizedBox(
          child: Text(
            'F/T',
            style: boldTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
      ];
  List<DataCell> cells(table, row) => [
        DataCell(SizedBox(
          width: 30,
          child: Text(
            time[table][row] ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataCell(SizedBox(
          width: 50,
          child: Text(
            countries[table][row]?.substring(0, 3).toUpperCase() ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataCell(SizedBox(
          width: 80,
          child: Text(
            teams[table][generateRow(table, row)] ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataCell(Text(
          tips[table][generateRow(table, row)] ?? "null",
          style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
        ).center()),
        DataCell(SizedBox(
          width: 30,
          child: Text(
            odds[table][generateRow(table, row)] ?? "null",
            style: primaryTextStyle(size: 12, color: btPrimaryTextColor),
          ),
        )),
        DataCell(Container(
          color: results[table][generateRow(table, row)] == '?'
              ? Colors.transparent
              : resultColorCodes[table][generateRow(table, row)]?.toColor(),
          padding: EdgeInsets.zero,
          height: 34,
          width: 60,
          child: Text(
            results[table][generateRow(table, row)]?.replaceAll("?", "") ??
                "null",
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
                    Column(
                      children: [
                        for (int table = 0; table < dates.length; table++)
                          Column(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'GOLD',
                                    style: boldTextStyle(
                                        color: btTableHeaderTextColor)),
                                TextSpan(
                                    text: ' TIPS OF ',
                                    style: boldTextStyle(
                                        color: btPrimaryTextColor)),
                                TextSpan(
                                    text: dates[table]?.lastChars(10),
                                    style: boldTextStyle(
                                        color: btHeaderDateColor)),
                              ])),
                              DataTable(
                                  columnSpacing: 15,
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
                                      3,
                                      (index) => DataRow(
                                          cells: cells(
                                              table, index)))).paddingAll(8),
                            ],
                          ),
                        Text(
                          btBottomMessage,
                          style:
                              primaryTextStyle(color: btTableHeaderTextColor),
                        ).paddingAll(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.copyright_outlined,
                              color: btTableHeaderTextColor,
                            ),
                            5.width,
                            Text(
                              'Dantech',
                              style:
                                  boldTextStyle(color: btTableHeaderTextColor),
                            )
                          ],
                        ).paddingAll(30).center(),
                      ],
                    ),
                  ],
                )),
          )),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
