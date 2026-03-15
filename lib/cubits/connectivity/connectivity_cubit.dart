import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<bool> {
  ConnectivityCubit(this._connectivity) : super(true) {
    _listenConnectivity();
  }

  final Connectivity _connectivity;

  void _listenConnectivity() {
    _connectivity.onConnectivityChanged.listen(
      (result) => emit(!result.contains(ConnectivityResult.none)),
    );
  }
}
