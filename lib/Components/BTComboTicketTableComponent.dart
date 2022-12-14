import 'package:sports_betting/Commons/BTColors.dart';
import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Components/BTMovingTextComponent.dart';
import 'package:sports_betting/Model/BTAllTipsModel.dart';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'package:sports_betting/Commons/BTEnums.dart';

import '../Provider/BTProvider.dart';

class BTComboTicketTableComponent extends StatelessWidget {
  const BTComboTicketTableComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration headerDecoration = BoxDecoration(
        color: btBackgroundBlueColor, border: Border.all(color: Colors.grey));
    BoxDecoration bodyDecoration = const BoxDecoration(
        color: btBackgroundTransparentColor,
        border: Border(bottom: BorderSide(color: Colors.grey)));
    double width = MediaQuery.of(context).size.width;
    String totalOdds(table, index) {
      var firstOdds = 0.0, secondOdds = 0.0, totalOdds = "0.0";
      switch (table) {
        case 0:
          firstOdds = odds[index][0].toDouble();
          secondOdds = odds[index][1].toDouble();
          break;
        case 1:
          firstOdds = odds[index][2].toDouble();
          secondOdds = odds[index][3].toDouble();
          break;
      }
      totalOdds = (firstOdds * secondOdds).toString();
      if (totalOdds.length > 4) {
        totalOdds = totalOdds.substring(0, 4);
      }
      return totalOdds;
    }

    int tableIndex(table, childTable) {
      switch (table) {
        case 0:
          switch (childTable) {
            default:
              return childTable;
          }
        case 1:
          switch (childTable) {
            default:
              return childTable + 2;
          }
        default:
          return childTable;
      }
    }

    Map<String, dynamic> resultsContainerContent(index, table) {
      var numberOfStars = 0,
          bgColor = "",
          firstBgColor = "",
          secondBgColor = "";
      switch (table) {
        case 0:
          firstBgColor = results[index][0] == '?'
              ? firstBgColor
              : resultColorCodes[index][0] ?? "";

          secondBgColor = results[index][1] == '?'
              ? secondBgColor
              : resultColorCodes[index][1] ?? "";
          break;
        case 1:
          firstBgColor = results[index][2] == '?'
              ? firstBgColor
              : resultColorCodes[index][2] ?? "";

          secondBgColor = results[index][3] == '?'
              ? secondBgColor
              : resultColorCodes[index][3] ?? "";
          break;
        default:
          return {"numberOfStars": "2", "bgColor": ""};
      }
      if (firstBgColor == secondBgColor) {
        bgColor = firstBgColor;
        if (bgColor == '#008000') {
          numberOfStars = 3;
        } else if (bgColor == "") {
          numberOfStars = 2;
        } else {
          numberOfStars = 1;
        }
      } else if (firstBgColor == '#008000' || secondBgColor == '#008000') {
        bgColor = '#008000';
        numberOfStars = 2;
      } else {
        bgColor = "";
        numberOfStars = 0;
      }
      return {"numberOfStars": numberOfStars, "bgColor": bgColor};
    }

    return Consumer<BTProvider>(
      builder: (context, provider, child) {
        Widget comboTable(index) => Column(
              children: [
                Text(
                  dates[index]?.lastChars(10) ?? "",
                  style: boldTextStyle(color: btHeaderDateColor),
                ).paddingSymmetric(vertical: 10),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Column(
                    children: [
                      for (int table = 0; table < 2; table++)
                        Column(
                          children: [
                            Column(
                              children: [
                                _comboTableTitle(width, headerDecoration),
                                for (int childTable = 0;
                                    childTable < 2;
                                    childTable++)
                                  Container(
                                      decoration: bodyDecoration,
                                      height: 34,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Text(
                                            '${time[index][tableIndex(table, childTable)]}',
                                            style: primaryTextStyle(
                                                color: btPrimaryTextColor,
                                                size: 12),
                                          )).withWidth(width * 0.08),
                                          const VerticalDivider(
                                            color: Colors.grey,
                                          ),
                                          Center(
                                              child: Text(
                                            '${countries[index][tableIndex(table, childTable)]?.substring(0, 3).toUpperCase()}',
                                            style: primaryTextStyle(
                                                color: btPrimaryTextColor,
                                                size: 12),
                                          )).withWidth(width * 0.08),
                                          const VerticalDivider(
                                            color: Colors.grey,
                                          ),
                                          Center(
                                              child: Text(
                                            '${teams[index][tableIndex(table, childTable)]}',
                                            style: primaryTextStyle(
                                                color: btPrimaryTextColor,
                                                size: 12),
                                          )).withWidth(width * 0.35),
                                          const VerticalDivider(
                                            color: Colors.grey,
                                          ),
                                          Center(
                                              child: Text(
                                            '${tips[index][tableIndex(table, childTable)]}',
                                            style: primaryTextStyle(
                                                color: btPrimaryTextColor,
                                                size: 12),
                                          )).withWidth(width * 0.08),
                                          const VerticalDivider(
                                            color: Colors.grey,
                                          ),
                                          Center(
                                              child: Text(
                                            '${odds[index][tableIndex(table, childTable)]}',
                                            style: primaryTextStyle(
                                                color: btPrimaryTextColor,
                                                size: 12),
                                          )).withWidth(width * 0.08),
                                          const VerticalDivider(
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            color: results[index][tableIndex(
                                                        table, childTable)] ==
                                                    '?'
                                                ? Colors.transparent
                                                : resultColorCodes[index][
                                                            tableIndex(table,
                                                                childTable)]
                                                        ?.toColor() ??
                                                    Colors.transparent,
                                            child: Center(
                                                child: Text(
                                              '${results[index][tableIndex(table, childTable)]?.replaceAll("?", "")}',
                                              style: primaryTextStyle(
                                                  color: btPrimaryTextColor,
                                                  size: 12),
                                            )).paddingAll(4),
                                          )
                                        ],
                                      )),
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: resultsContainerContent(
                                            index, table)["bgColor"]
                                        .toString()
                                        .toColor(),
                                    border: Border.all(color: Colors.grey)),
                                height: 34,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      '',
                                      style: primaryTextStyle(
                                          color: btPrimaryTextColor, size: 12),
                                    )).withWidth(width * 0.59),
                                    const VerticalDivider(
                                      color: Colors.grey,
                                    ),
                                    Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i <
                                                resultsContainerContent(index,
                                                    table)["numberOfStars"];
                                            i++)
                                          const Icon(
                                            Icons.star,
                                            size: 10,
                                            color: Colors.orange,
                                          ),
                                      ],
                                    )).withWidth(width * 0.08),
                                    const VerticalDivider(
                                      color: Colors.grey,
                                    ),
                                    Center(
                                        child: Text(
                                      totalOdds(table, index),
                                      style: primaryTextStyle(
                                          color: btPrimaryTextColor, size: 12),
                                    )).withWidth(width * 0.08),
                                    const VerticalDivider(
                                      color: Colors.grey,
                                    ),
                                    Center(
                                        child: Text(
                                      '',
                                      style: primaryTextStyle(
                                          color: btPrimaryTextColor, size: 12),
                                    ))
                                  ],
                                )),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );

        return Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              BTMovingTextComponent(
                textColor: btTableHeaderTextColor,
                text: btHeaderMessage,
                decoration: headerDecoration,
              ),
              15.height,
              for (int i = 0; i < dates.length; i++) comboTable(i)
            ],
          ),
        );
      },
    );
  }
}

Widget _comboTableTitle(width, decoration) => Container(
    decoration: decoration,
    height: 34,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Text(
          'TIME',
          style: primaryTextStyle(color: btPrimaryTextColor, size: 12),
        )).withWidth(width * 0.08),
        const VerticalDivider(
          color: Colors.grey,
        ),
        Center(
            child: Text(
          'LEAGUE',
          style: primaryTextStyle(color: btPrimaryTextColor, size: 12),
        )).withWidth(width * 0.08),
        const VerticalDivider(
          color: Colors.grey,
        ),
        Center(
            child: Text(
          'TEAMS',
          style: primaryTextStyle(color: btPrimaryTextColor, size: 12),
        )).withWidth(width * 0.35),
        const VerticalDivider(
          color: Colors.grey,
        ),
        Center(
            child: Text(
          'TIPS',
          style: primaryTextStyle(color: btPrimaryTextColor, size: 12),
        )).withWidth(width * 0.08),
        const VerticalDivider(
          color: Colors.grey,
        ),
        Center(
            child: Text(
          'ODDS',
          style: primaryTextStyle(color: btPrimaryTextColor, size: 12),
        )).withWidth(width * 0.08),
        const VerticalDivider(
          color: Colors.grey,
        ),
        Center(
            child: Text(
          'F.S',
          style: primaryTextStyle(color: btPrimaryTextColor, size: 12),
        ))
      ],
    ));
