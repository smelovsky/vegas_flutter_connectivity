import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WiFiAccessPointNotifier extends ChangeNotifier {
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
}

final WiFiAccessPointProvider =
ChangeNotifierProvider<WiFiAccessPointNotifier>((ref) {
  return WiFiAccessPointNotifier();
});


class WiFiScanErrorNotifier extends ChangeNotifier {
  String error = "";
}

final WiFiScanErrorProvider =
ChangeNotifierProvider<WiFiScanErrorNotifier>((ref) {
  return WiFiScanErrorNotifier();
});


class WiFiGetErrorNotifier extends ChangeNotifier {
  String error = "";
}

final WiFiGetErrorProvider =
ChangeNotifierProvider<WiFiGetErrorNotifier>((ref) {
  return WiFiGetErrorNotifier();
});