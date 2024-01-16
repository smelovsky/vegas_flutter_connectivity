import 'package:flutter/cupertino.dart';
import 'no_network_widget.dart';

class MainBuilder {
  MainBuilder._privateConstructor();

  static Widget build(BuildContext context, Widget? child) {
    return Column(
      children: [
        Expanded(
          child: child!,
        ),
        const NoNetworkWidget(),
      ],
    );
  }
}