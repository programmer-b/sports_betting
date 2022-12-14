import 'package:sports_betting/Commons/BTColors.dart';
import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Components/BTBackgroundComponent.dart';
import '../Components/BTDrawerComponent.dart';
import '../Provider/BTProvider.dart';
import '../Utils/BTAdhelper.dart';

class BTAboutUsScreen extends StatefulWidget {
  const BTAboutUsScreen({Key? key}) : super(key: key);

  @override
  State<BTAboutUsScreen> createState() => _BTAboutUsScreenState();
}

class _BTAboutUsScreenState extends State<BTAboutUsScreen> {
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
            child: Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(btBackgroundImageAsset),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  color: const Color(0x99000000),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'About us',
                        style: boldTextStyle(
                            size: 20,
                            color: btHeaderDateColor,
                            decoration: TextDecoration.underline),
                      ).paddingBottom(20),
                      Text(
                        'Who we are',
                        style: boldTextStyle(color: btTableHeaderTextColor),
                      ).paddingOnly(bottom: 4, top: 15),
                      Text(
                        'We are a team of passionate sport bettors and we love what we do. We like to analyze all opportunities and have a best chance of winning when we place a bet.',
                        style: primaryTextStyle(
                          color: btPrimaryTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 8),
                      Text(
                        'Our goal',
                        style: boldTextStyle(color: btTableHeaderTextColor),
                      ).paddingOnly(bottom: 4, top: 15),
                      Text(
                        'Our main goals is to share good opinions and information to the sport betting community, because together we can grow stronger',
                        style: primaryTextStyle(
                          color: btPrimaryTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 8),
                      Text(
                        'What we do',
                        style: boldTextStyle(color: btTableHeaderTextColor),
                      ).paddingOnly(bottom: 4, top: 15),
                      Text(
                        'Every day we study many games and then we select the best ones, matches with big odds and highest probability to generate profit. After selecting our best tips we share on our apps with you guys, for free, with the intention of creating a strong and very well informed community',
                        style: primaryTextStyle(
                          color: btPrimaryTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 8),
                    ],
                  ).paddingSymmetric(vertical: 30, horizontal: 10),
                ),
              ),
            ),
          )),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
