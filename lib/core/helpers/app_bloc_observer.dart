import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

class AppBlocObserver extends BlocObserver {
  static const String _nextLine = '\n';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log.info(
        'onCreate => ${bloc.state.runtimeType} created${_nextLine}initState => ${bloc.state.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.info(
        'onChange => ${bloc.state.runtimeType} changed${_nextLine}currentState => ${change.currentState.runtimeType}${_nextLine}nextState => ${change.nextState.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.info(
        'onEvent => ${bloc.state.runtimeType} event added${_nextLine}event => $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.info(
        'onTransition => ${bloc.state.runtimeType} transition added${_nextLine}transition => $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log.info(
        'onError => ${bloc.state.runtimeType} error occured${_nextLine}error => $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log.info('onClose => ${bloc.state.runtimeType} closed');
  }
}
