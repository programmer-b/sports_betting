import 'package:sports_betting/Commons/BTColors.dart';
import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Components/BTBackgroundComponent.dart';
import 'package:sports_betting/Components/BTBettingTipsTableComponent.dart';
import 'package:sports_betting/Components/BTDrawerComponent.dart';
import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:sports_betting/Components/BTTopMenuLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Provider/BTProvider.dart';
import '../Utils/BTAdhelper.dart';

class BTBettingTipsScreen extends StatefulWidget {
  const BTBettingTipsScreen({Key? key}) : super(key: key);

  @override
  State<BTBettingTipsScreen> createState() => _BTBettingTipsScreenState();
}

class _BTBettingTipsScreenState extends State<BTBettingTipsScreen> {
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
                    Text(
                      btTableHeaderMessage,
                      style: boldTextStyle(color: btTableHeaderTextColor),
                    ).paddingSymmetric(vertical: 8),
                    const BTBettingTipsTableComponent(),
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
