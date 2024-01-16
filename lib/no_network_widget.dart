import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vegas_flutter_connectivity/context_extensions.dart';
import 'connectivity/duration_items.dart';
import 'connectivity/network_notifier.dart';
import 'connectivity/network_result.dart';
import 'constants.dart';


class NoNetworkWidget extends ConsumerWidget {
  const NoNetworkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedCrossFade(
      firstChild: Material(
        child: buildErrorMessageContainer(context),
      ),
      secondChild: Material(
        child: buildStatusMessageContainer(context),
      ),
      crossFadeState: ref.watch(networkNotifierProvider) ==
          NetworkResult.off
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const DurationItems.durationLow(),
    );
  }

  Container buildErrorMessageContainer(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: context.width,
      height: context.dynamicHeight(0.05),
      color: context.colorScheme.primary,
      child: const Text(Constants.noNetworkMessage),
    );
  }

  Container buildStatusMessageContainer(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: context.width,
      height: context.dynamicHeight(0.05),
      //color: context.colorScheme.primary,
      child: const Text(Constants.positiveMessage),
    );
  }

  SizedBox buildEmptySizedBox(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 0,
    );
  }
}
