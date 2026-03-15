import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/locator.dart';
import '../../helpers/app_sentry.dart';
import '../../helpers/logger.dart';
import '../../network/global_failure.dart';
import '../../services/internet_checker_service.dart';

part 'base_state.dart';

abstract class BaseCubit<T> extends Cubit<BaseState<T>> {
  BaseCubit() : super(Initial<T>());

  T? _result;

  @protected
  T? get result => _result;

  bool _isBusy = false;

  @protected
  bool get isBusy => _isBusy;

  @protected
  Future<void> run({
    required Future<T?> Function() onProcess,
    Future<void> Function(T? data)? onSuccess,
  }) async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      emit(Loading<T>());
      final hasInternetConnection =
          await locator<InternetCheckerService>().hasInternetConnection();
      if (!hasInternetConnection) {
        emit(NetworkFailure<T>());
        return;
      }
      _result = await onProcess();
      if (_result is T) {
        await onSuccess?.call(_result);
        emit(Success<T>());
        return;
      }
      emit(Failure<T>());
    } on DioException catch (e, s) {
      AppSentry.captureError(e, s);
      emit(Failure<T>());
    } catch (e, s) {
      log.error('$e');
      log.error('$s');
      AppSentry.captureError(e, s);
      emit(Failure<T>());
    } finally {
      _isBusy = false;
    }
  }
}
