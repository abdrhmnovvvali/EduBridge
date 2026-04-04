part of 'student_materials_cubit.dart';

sealed class StudentMaterialsState extends Equatable {
  const StudentMaterialsState();
  @override
  List<Object?> get props => [];
}

final class StudentMaterialsInitial extends StudentMaterialsState {}
final class StudentMaterialsLoading extends StudentMaterialsState {}
final class StudentMaterialsSuccess extends StudentMaterialsState {
  const StudentMaterialsSuccess({
    required this.materials,
    required this.page,
    required this.totalPages,
    required this.total,
  });

  final List<MaterialResponse> materials;
  final int page;
  final int totalPages;
  final int total;

  @override
  List<Object?> get props => [materials, page, totalPages, total];
}
final class StudentMaterialsError extends StudentMaterialsState {
  const StudentMaterialsError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
