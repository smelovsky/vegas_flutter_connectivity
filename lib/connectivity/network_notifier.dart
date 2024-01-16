import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'network_result.dart';

class NetworkNotifier extends StateNotifier<NetworkResult> {
  NetworkNotifier(NetworkResult state) : super(state) {
    init();
  }

  Future<void> init() async {
    final Connectivity connectivity = Connectivity();
    await checkInitialConnection(connectivity);
    subscribeToTheConnectionChange(connectivity);
  }

  Future<void> checkInitialConnection(
      Connectivity connectivity) async {
    var connectivityResult = await connectivity.checkConnectivity();
    state = NetworkResult.checkConnectivity(connectivityResult);
  }

  void subscribeToTheConnectionChange(Connectivity connectivity) {
    connectivity.onConnectivityChanged.listen((event) {
      state = NetworkResult.checkConnectivity(event);
    });
  }
}

//create a global provider object
final networkNotifierProvider =
StateNotifierProvider<NetworkNotifier, NetworkResult>((ref) {
  return NetworkNotifier(NetworkResult.off);
});







