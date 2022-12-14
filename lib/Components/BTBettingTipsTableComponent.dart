import 'package:sports_betting/Commons/BTColors.dart';
import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Components/BTMovingTextComponent.dart';
import 'package:sports_betting/Model/BTAllTipsModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Provider/BTProvider.dart';

class BTBettingTipsTableComponent extends StatelessWidget {
  const BTBettingTipsTableComponent({Key? key}) : super(key: key);

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
        Widget tipsTable(index) => Column(
              children: [
                Text(
                  dates[index] ?? "",
                  style: boldTextStyle(color: btHeaderDateColor),
                ).paddingSymmetric(vertical: 5),
                for (int i = 0; i < 3; i++)
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
                                  child:
                                      Image.network(flagUrls[index][i] ?? ""),
                                ),
                              ).paddingSymmetric(horizontal: 4),
                              Text(
                                ' ${countries[index][i]?.replaceAll('\n', '') ?? "null"} - ${time[index][i] ?? "null"} GMT - ',
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
                                teams[index][i] ?? "null",
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
                                  Text(tips[index][i]?.toUpperCase() ?? "null",
                                          style: secondaryTextStyle(
                                              color: btPrimaryTextColor,
                                              size: 14))
                                      .paddingTop(5),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  Text(odds[index][i] ?? "null",
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
                                color: results[index][i] == '?'
                                    ? Colors.transparent
                                    : resultColorCodes[index][i]?.toColor() ??
                                        Colors.transparent,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        results[index][i]
                                                ?.replaceAll('?', '') ??
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
              for (int i = 0; i < dates.length; i++) tipsTable(i),
            ],
          ).withWidth(double.infinity),
        );
      },
    );
  }
}
