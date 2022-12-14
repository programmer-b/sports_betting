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

class BTContactUsScreen extends StatefulWidget {
  const BTContactUsScreen({Key? key}) : super(key: key);

  @override
  State<BTContactUsScreen> createState() => _BTContactUsScreenState();
}

class _BTContactUsScreenState extends State<BTContactUsScreen> {
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
                    children: [
                      Text(
                        'Customer Support Center',
                        style: boldTextStyle(
                            color: btTableHeaderTextColor,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                      10.height,
                      Text(
                        'Whether you are looking for answers, would like to solve a problem, or want to just let us know how we did , you will find a way to contact us here. We\'ll help you resolve your issues quickly and easily, getting you back to more important things like relaxing on your sofa.\n\n Operating Hours:\nMonday-Saturday: 8:00am - 12:00am\nSunday: 9:00am - 12:00am\nEMAIL: programmerdante@gmail.com\nsimonkandia00@gmail.com',
                        style: boldTextStyle(
                          color: btHeaderDateColor,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ).paddingSymmetric(vertical: 20, horizontal: 10),
          )),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
