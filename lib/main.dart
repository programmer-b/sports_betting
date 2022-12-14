import 'package:sports_betting/Screens/BTBettingTipsScreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Provider/BTProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BTProvider(),
      child: MaterialApp(
        title: 'Premium betting tips',
        theme: ThemeData(
            primarySwatch: Colors.cyan,
            appBarTheme: AppBarTheme(color: Color.fromARGB(255, 37, 24, 214))),
        home: RestartAppWidget(
          child: Builder(builder: (context) {
            context.read<BTProvider>().btLoadAndStructureData();
            return const BTBettingTipsScreen();
          }),
        ),
      ),
    );
  }
}
