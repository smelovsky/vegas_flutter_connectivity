import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vegas_flutter_connectivity/wifi/wifi_notifier.dart';
import 'package:wifi_scan/wifi_scan.dart';

Future<void> startScan(WidgetRef ref) async {

  final can = await WiFiScan.instance.canStartScan();

  if (can != CanStartScan.yes) {
    ref.refresh(WiFiScanErrorProvider).error = "Cannot start scan: $can";
    return;
  }

  final result = await WiFiScan.instance.startScan();

}

Future<bool> canGetScannedResults(WidgetRef ref) async {

  final can = await WiFiScan.instance.canGetScannedResults();

  if (can != CanGetScannedResults.yes) {

    ref.refresh(WiFiGetErrorProvider).error = "Error to get scanned results";
    ref.refresh(WiFiAccessPointProvider).accessPoints = <WiFiAccessPoint>[];

    return false;
  }

  return true;
}

Future<void> getScannedResults(WidgetRef ref) async {
  if (await canGetScannedResults(ref)) {

    final results = await WiFiScan.instance.getScannedResults();
    ref.refresh(WiFiAccessPointProvider).accessPoints = results;
  }
}