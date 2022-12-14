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

class BTTermsOfUseScreen extends StatefulWidget {
  const BTTermsOfUseScreen({Key? key}) : super(key: key);

  @override
  State<BTTermsOfUseScreen> createState() => _BTTermsOfUseScreenState();
}

class _BTTermsOfUseScreenState extends State<BTTermsOfUseScreen> {
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
              child: Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: const Center(child: Text(btTermsOfUse))
                        .paddingSymmetric(horizontal: 10, vertical: 20),
                  )),
            ),
          ),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
