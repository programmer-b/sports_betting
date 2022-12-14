import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BTMenuComponent extends StatelessWidget {
  const BTMenuComponent({Key? key, required this.icon, required this.title})
      : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Icon(icon), 8.width, Text(title)],
    );
  }
}
