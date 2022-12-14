import 'package:sports_betting/Components/BTBackgroundComponent.dart';
import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:sports_betting/Components/BTTopMenuLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Components/BTDrawerComponent.dart';
import '../Provider/BTProvider.dart';
import '../Utils/BTAdhelper.dart';

class BTFlashScoreScreen extends StatefulWidget {
  const BTFlashScoreScreen({Key? key}) : super(key: key);

  @override
  State<BTFlashScoreScreen> createState() => _BTFlashScoreScreenState();
}

class _BTFlashScoreScreenState extends State<BTFlashScoreScreen> {
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
                  children: const [BTTopMenuLayout()],
                )),
          )),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
