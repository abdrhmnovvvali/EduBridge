part of 'student_invoices_cubit.dart';

sealed class StudentInvoicesState extends Equatable {
  const StudentInvoicesState();
  @override
  List<Object?> get props => [];
}

final class StudentInvoicesInitial extends StudentInvoicesState {}
final class StudentInvoicesLoading extends StudentInvoicesState {}
final class StudentInvoicesSuccess extends StudentInvoicesState {
  const StudentInvoicesSuccess(this.invoices);
  final List<InvoiceResponse> invoices;
  @override
  List<Object?> get props => [invoices];
}
final class StudentInvoicesError extends StudentInvoicesState {
  const StudentInvoicesError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
