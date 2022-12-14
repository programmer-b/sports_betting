import 'package:sports_betting/Commons/BTColors.dart';
import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Components/BTMovingTextComponent.dart';
import 'package:sports_betting/Model/BTAllTipsModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Provider/BTProvider.dart';

class BTDailyAccaTipsTableComponent extends StatelessWidget {
  const BTDailyAccaTipsTableComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration headerDecoration = const BoxDecoration(
        color: btBackgroundBlueColor,
        border: Border(
            bottom: BorderSide(color: Colors.grey),
            top: BorderSide(color: Colors.grey)));
    BoxDecoration bodyDecoration = const BoxDecoration(
        color: btBackgroundTransparentColor,
        border: Border(bottom: BorderSide(color: Colors.grey)));
    return Consumer<BTProvider>(
      builder: (context, provider, child) {
        double width = MediaQuery.of(context).size.width;
        Widget tipsTable() => Column(
              children: [
                Text(
                  dates[0] ?? "Free betting tips for today",
                  style: boldTextStyle(color: btHeaderDateColor),
                ).paddingSymmetric(vertical: 5),
                for (int i = 0; i < time[0].length; i++)
                  Column(
                    children: [
                      Container(
                          height: 25,
                          decoration: headerDecoration,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: "#ff8000".toColor(),
                                child: ClipOval(
                                  child: Image.network(flagUrls[0][i] ?? ""),
                                ),
                              ).paddingSymmetric(horizontal: 4),
                              Text(
                                ' ${countries[0][i]?.replaceAll('\n', '') ?? "null"} - ${time[0][i] ?? "null"} GMT - ',
                                style: boldTextStyle(
                                    color: btPrimaryTextColor, size: 14),
                              ),
                              for (int i = 0; i < 3; i++)
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 14,
                                )
                            ],
                          )),
                      Container(
                          height: 25,
                          decoration: bodyDecoration,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                teams[0][i] ?? "null",
                                style: secondaryTextStyle(
                                    color: btPrimaryTextColor, size: 14),
                              ).withWidth(width * 0.50).paddingOnly(top: 5),
                              const VerticalDivider(
                                color: Colors.grey,
                                width: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(tips[0][i]?.toUpperCase() ?? "null",
                                          style: secondaryTextStyle(
                                              color: btPrimaryTextColor,
                                              size: 14))
                                      .paddingTop(5),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  Text(odds[0][i] ?? "null",
                                      style: secondaryTextStyle(
                                          color: btPrimaryTextColor, size: 14)),
                                ],
                              ).withWidth(width * 0.4)
                            ],
                          ).paddingSymmetric(horizontal: 5)),
                      Container(
                          height: 25,
                          decoration: bodyDecoration,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Final results',
                                style: secondaryTextStyle(
                                    color: btPrimaryTextColor, size: 14),
                              ).withWidth(width * 0.5).paddingLeft(5),
                              const VerticalDivider(
                                color: Colors.grey,
                                width: 2,
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                color: results[0][i] == '?'
                                    ? Colors.transparent
                                    : resultColorCodes[0][i]?.toColor() ??
                                        Colors.transparent,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        results[0][i]?.replaceAll('?', '') ??
                                            "null",
                                        style: secondaryTextStyle(
                                            color: btPrimaryTextColor,
                                            size: 14)),
                                  ],
                                ),
                              ).withWidth(width * 0.4),
                            ],
                          )),
                    ],
                  ),
              ],
            );
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Column(
            children: [
              BTMovingTextComponent(
                textColor: btTableHeaderTextColor,
                text: btHeaderMessage,
                decoration: headerDecoration,
              ),
              tipsTable(),
            ],
          ).withWidth(double.infinity),
        );
      },
    );
  }
}
