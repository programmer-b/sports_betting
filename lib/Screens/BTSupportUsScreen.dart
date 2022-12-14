import 'package:sports_betting/Components/BTLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/BTBackgroundComponent.dart';
import '../Components/BTDrawerComponent.dart';
import '../Provider/BTProvider.dart';

class BTSupportUsScreen extends StatefulWidget {
  const BTSupportUsScreen({Key? key}) : super(key: key);

  @override
  State<BTSupportUsScreen> createState() => _BTSupportUsScreenState();
}

class _BTSupportUsScreenState extends State<BTSupportUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BTProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.currentScreenTitle),
          ),
          body: const BTLoadingComponent(
              child: BTBackgroundComponent(
            child: Center(),
          )),
          drawer: const BTDrawerComponent(),
        );
      },
    );
  }
}
