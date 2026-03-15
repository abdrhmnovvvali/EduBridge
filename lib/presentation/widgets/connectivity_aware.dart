import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/connectivity/connectivity_cubit.dart';
import 'no_connectivty_view.dart';

class ConnectivityAware extends StatelessWidget {
  const ConnectivityAware({
    required this.whenConnected,
    this.whenNotConnected,
    super.key,
  });

  final Widget whenConnected;
  final Widget? whenNotConnected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, bool>(
      listener: (_, isConnected) {
        if (isConnected) {
          // Call api
        }
      },
      builder: (_, isConnected) => Stack(
        children: [
          whenConnected,
          if (!isConnected) whenNotConnected ?? const NoConnectivtyView(),
        ],
      ),
    );
  }
}
