import 'package:sports_betting/Commons/BTInfo.dart';
import 'package:sports_betting/Components/BTMenuComponent.dart';
import 'package:sports_betting/Provider/BTProvider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/BTMenu.dart';
import 'BTDrawerHeaderComponent.dart';

class BTDrawerComponent extends StatefulWidget {
  const BTDrawerComponent({Key? key}) : super(key: key);

  @override
  State<BTDrawerComponent> createState() => _BTDrawerComponentState();
}

class _BTDrawerComponentState extends State<BTDrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BTDrawerHeaderComponent(),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Text(
                'MENU',
                style: primaryTextStyle(),
              ).paddingOnly(left: 16),
              8.height,
              for (int index = 0; index < menu.length; index++)
                _menuTileWidget(
                  context,
                  index: index,
                ),
              8.height,
              const Divider(
                color: Colors.black54,
              ),
              8.height,
              Text(
                'INFO',
                style: primaryTextStyle(),
              ).paddingOnly(left: 16),
              8.height,
              for (int index = menu.length;
                  index < menu.length + info.length;
                  index++)
                _menuTileWidget(
                  context,
                  index: index,
                ),
            ],
          ))
        ],
      ),
    );
  }
}

Widget _menuTileWidget(context, {required int index}) {
  final provider = Provider.of<BTProvider>(context);
  var menus = List.from(menu)..addAll(info);

  return Container(
    color:
        provider.currentIndex == index ? Colors.grey[300] : Colors.transparent,
    child: BTMenuComponent(
      icon: menus[index]['icon'],
      title: menus[index]['name'],
    ).paddingOnly(left: 16, top: 8, bottom: 8),
  )
      .withWidth(MediaQuery.of(context).size.width)
      .onTap(() => provider.updateScreen(context, index: index));
}
