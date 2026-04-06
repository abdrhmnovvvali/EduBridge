import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:eduroom/core/controllers/session_controller.dart';
import 'package:eduroom/data/contracts/login/login_contract.dart';
import 'package:eduroom/data/models/remote/request/login_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/di/locator.dart';
import '../../core/enums/user_role.dart';
import '../../core/services/student_push_token_service.dart';
import '../../core/helpers/logger.dart';
import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._internetCheckerService, this._authContract)
    : super(LoginInitial());

  final InternetCheckerService _internetCheckerService;
  final LoginContract _authContract;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> handleTeacherLogin() async {
    if (!formKey.currentState!.validate()) return;
    await teacherLogin();
  }

  Future<void> handleStudentLogin() async {
    if (!formKey.currentState!.validate()) return;
    await studentLogin();
  }


  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    await teacherLogin(silentOnFailure: true);
    final state = this.state;
    if (state is LoginFailure || state is LoginNetworkError) {
      await studentLogin();
    }
  }

  Future<void> teacherLogin({bool silentOnFailure = false}) async {
    try {
      emit(LoginLoading());
      final hasInternetConnection = await _internetCheckerService
          .hasInternetConnection();
      if (!hasInternetConnection) {
        emit(LoginNetworkError(
          failure: GlobalFailure.network(),
          suppressSnackbar: silentOnFailure,
        ));
        return;
      }

      final result = await _authContract.teacherLogin(
        LoginParams(
          emailOrPhone: emailController.text,
          password: passwordController.text,
        ),
      );

      await SessionController.saveSessionResponse(result);
      if (result.user.role.toUpperCase() == 'STUDENT') {
        unawaited(locator<StudentPushTokenService>().registerAfterLogin());
      }
      final role = result.user.role == "TEACHER"
          ? UserRole.teacher
          : UserRole.student;

      emit(LoginSuccess(role: role));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      final errorMessage =
          e.response?.data['error'] ?? const GlobalFailure.server().message;
      emit(LoginFailure(
        failure: GlobalFailure(errorMessage),
        suppressSnackbar: silentOnFailure,
      ));
    } catch (e, s) {
      log.error('$e');
      log.error('$s');
      await Sentry.captureException(e, stackTrace: s);
      emit(LoginFailure(
        failure: GlobalFailure.server(),
        suppressSnackbar: silentOnFailure,
      ));
    }
  }

  Future<void> studentLogin() async {
    if (!formKey.currentState!.validate()) return;

    try {
      emit(LoginLoading());
      final hasInternetConnection = await _internetCheckerService
          .hasInternetConnection();
      if (!hasInternetConnection) {
        emit(const LoginNetworkError(failure: GlobalFailure.network()));
        return;
      }

      final result = await _authContract.studentLogin(
        LoginParams(
          emailOrPhone: emailController.text,
          password: passwordController.text,
        ),
      );

      await SessionController.saveSessionResponse(result);
      if (result.user.role.toUpperCase() == 'STUDENT') {
        unawaited(locator<StudentPushTokenService>().registerAfterLogin());
      }
      final role = result.user.role == "STUDENT"
          ? UserRole.student
          : UserRole.teacher;

      emit(LoginSuccess(role: role));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      final errorMessage =
          e.response?.data['error'] ?? const GlobalFailure.server().message;
      emit(LoginFailure(failure: GlobalFailure(errorMessage)));
    } catch (e, s) {
      log.error('$e');
      log.error('$s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const LoginFailure(failure: GlobalFailure.server()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
