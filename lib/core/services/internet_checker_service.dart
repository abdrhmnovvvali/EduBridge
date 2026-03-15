import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

class InternetCheckerService {
  InternetCheckerService() {
    // Start listening to connectivity changes
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // Also check once at startup
    _init();
  }

  final Connectivity _connectivity = Connectivity();
  final _internetStatusSubject = BehaviorSubject<bool>();

  Stream<bool> get internetStatusStream => _internetStatusSubject.stream;

  Future<void> _init() async {
    final status = await hasInternetConnection();
    _internetStatusSubject.add(status);
  }

  Future<bool> hasInternetConnection() async {
    final result = await _connectivity.checkConnectivity();
    final isOffline = result.contains(ConnectivityResult.none);
    if (isOffline) return false;

    return await _checkInternetAccess();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      _internetStatusSubject.add(false);
    } else {
      final hasInternet = await _checkInternetAccess();
      _internetStatusSubject.add(hasInternet);
    }
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  void dispose() {
    _internetStatusSubject.close();
  }
}
