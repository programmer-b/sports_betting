import 'package:sports_betting/Components/BTMenuButton.dart';
import 'package:sports_betting/Provider/BTProvider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/BTMenu.dart';

class BTTopMenuLayout extends StatelessWidget {
  const BTTopMenuLayout({Key? key}) : super(key: key);

  int generateNavigationIndex(var provider, var index) {
    if (index >= provider.currentIndex) {
      return index + 1;
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    var topMenus = [];
    topMenus.addAll(menu);

    return Consumer<BTProvider>(
      builder: (context, provider, child) {
        topMenus.removeAt(provider.currentIndex);
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: <Widget>[
            for (int i = 0; i < 6; i++)
              BTMenuButton(
                text: topMenus[i]['name'],
                onTap: () => provider.updateScreen(context,
                    index: generateNavigationIndex(provider, i),
                    pageRouteAnimation: null),
              ),
          ],
        ).paddingAll(16);
      },
    );
  }
}
