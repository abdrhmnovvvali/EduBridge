import 'package:dio/dio.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:eduroom/data/contracts/student_data/student_data_contract.dart';
import 'package:eduroom/data/models/remote/response/student/invoice_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/network/global_failure.dart';
import '../../core/services/internet_checker_service.dart';

part 'student_invoices_state.dart';

class StudentInvoicesCubit extends Cubit<StudentInvoicesState> {
  StudentInvoicesCubit(this._internetCheckerService, this._contract) : super(StudentInvoicesInitial());

  final InternetCheckerService _internetCheckerService;
  final StudentDataContract _contract;

  Future<void> load() async {
    try {
      emit(StudentInvoicesLoading());
      final hasInternet = await _internetCheckerService.hasInternetConnection();
      if (!hasInternet) {
        emit(const StudentInvoicesError(failure: GlobalFailure.network()));
        return;
      }
      final list = await _contract.getInvoices();
      emit(StudentInvoicesSuccess(list));
    } on DioException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(StudentInvoicesError(failure: GlobalFailure(e.response?.data['message'] ?? 'Error')));
    } catch (e, s) {
      log.error('$e $s');
      await Sentry.captureException(e, stackTrace: s);
      emit(const StudentInvoicesError(failure: GlobalFailure.server()));
    }
  }
}
