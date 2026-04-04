part of 'student_materials_cubit.dart';

sealed class StudentMaterialsState extends Equatable {
  const StudentMaterialsState();
  @override
  List<Object?> get props => [];
}

final class StudentMaterialsInitial extends StudentMaterialsState {}
final class StudentMaterialsLoading extends StudentMaterialsState {}
final class StudentMaterialsSuccess extends StudentMaterialsState {
  const StudentMaterialsSuccess(this.materials);
  final List<MaterialResponse> materials;
  @override
  List<Object?> get props => [materials];
}
final class StudentMaterialsError extends StudentMaterialsState {
  const StudentMaterialsError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
