part of 'teacher_materials_cubit.dart';

sealed class TeacherMaterialsState extends Equatable {
  const TeacherMaterialsState();
  @override
  List<Object?> get props => [];
}

final class TeacherMaterialsInitial extends TeacherMaterialsState {}
final class TeacherMaterialsLinking extends TeacherMaterialsState {}
final class TeacherMaterialsSuccess extends TeacherMaterialsState {}
final class TeacherMaterialsError extends TeacherMaterialsState {
  const TeacherMaterialsError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
