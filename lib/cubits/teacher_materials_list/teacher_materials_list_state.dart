part of 'teacher_materials_list_cubit.dart';

sealed class TeacherMaterialsListState extends Equatable {
  const TeacherMaterialsListState();
  @override
  List<Object?> get props => [];
}

final class TeacherMaterialsListInitial extends TeacherMaterialsListState {}

final class TeacherMaterialsListLoading extends TeacherMaterialsListState {}

final class TeacherMaterialsListSuccess extends TeacherMaterialsListState {
  const TeacherMaterialsListSuccess({
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

final class TeacherMaterialsListError extends TeacherMaterialsListState {
  const TeacherMaterialsListError({required this.failure});
  final GlobalFailure failure;
  @override
  List<Object?> get props => [failure];
}
