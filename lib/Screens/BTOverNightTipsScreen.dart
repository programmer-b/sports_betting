import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:sports_betting/Components/BTTopMenuLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/BTColors.dart';
import '../Commons/BTStrings.dart';
import '../Components/BTBackgroundComponent.dart';
import '../Components/BTDrawerComponent.dart';
import '../Model/BTAllTipsModel.dart';
import '../Provider/BTProvider.dart';
import '../Utils/BTAdhelper.dart';

class BTOverNightTipsScreen extends StatefulWidget {
  const BTOverNightTipsScreen({Key? key}) : super(key: key);

  @override
  State<BTOverNightTipsScreen> createState() => _BTOverNightTipsScreenState();
}

class _BTOverNightTipsScreenState extends State<BTOverNightTipsScreen> {
  List<DataColumn> columns(table) => [
        DataColumn(
            label: SizedBox(
          child: Text(
            'FLAG',
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
        DataCell(
          SizedBox(
            width: 30,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(flagUrls[table][row] ?? ""),
              ),
            ).paddingSymmetric(horizontal: 4),
          ),
        ),
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
          color: results[table][row] == '?'
              ? Colors.transparent
              : resultColorCodes[table][row]?.toColor(),
          padding: EdgeInsets.zero,
          height: 34,
          width: 60,
          child: Text(
            results[table][row]?.replaceAll("?", "") ?? "null",
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
                    for (int table = 0; table < dates.length; table++)
                      DataTable(
                          columnSpacing: 15,
                          dataRowHeight: 34,
                          headingRowHeight: 34,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => btBackgroundBlueColor),
                          border: TableBorder.all(
                            color: Colors.grey,
                          ),
                          columns: columns(table),
                          rows: [
                            for (int index = 5;
                                index < time[table].length - 3;
                                index++)
                              if (index % 2 != 0)
                                DataRow(cells: cells(table, index))
                          ]).paddingAll(8),
                    Text(
                      btBottomMessage,
                      style: primaryTextStyle(color: btTableHeaderTextColor),
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
                          style: boldTextStyle(color: btTableHeaderTextColor),
                        )
                      ],
                    ).paddingAll(30).center(),
                  ],
                )),
          )),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
