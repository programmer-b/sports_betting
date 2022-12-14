import 'package:sports_betting/Commons/BTColors.dart';
import 'package:sports_betting/Provider/BTProvider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class BTLoadingComponent extends StatefulWidget {
  const BTLoadingComponent({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<BTLoadingComponent> createState() => _BTLoadingComponentState();
}

class _BTLoadingComponentState extends State<BTLoadingComponent> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BTProvider>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: provider.btLoading
          ? LoadingAnimationWidget.discreteCircle(
                  color: btPrimaryColor, size: 40)
              .center()
          : provider.btLoadSuccess
              ? widget.child
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.btConnectionErrorMessage,
                      style: primaryTextStyle(size: 17),
                    ),
                    10.height,
                    ElevatedButton(
                        onPressed: () => RestartAppWidget.init(context),
                        child: const Text('Retry'))
                  ],
                ).center(),
    );
  }
}
