import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:sports_betting/Components/BTTopMenuLayout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/BTBackgroundComponent.dart';
import '../Components/BTDrawerComponent.dart';
import '../Provider/BTProvider.dart';

class BTStatiquesScreen extends StatefulWidget {
  const BTStatiquesScreen({Key? key}) : super(key: key);

  @override
  State<BTStatiquesScreen> createState() => _BTStatiquesScreenState();
}

class _BTStatiquesScreenState extends State<BTStatiquesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BTProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.currentScreenTitle),
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
