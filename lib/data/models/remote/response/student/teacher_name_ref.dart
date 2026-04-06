/// Müəllim qısa məlumatı (teacher: { id, fullName }).
class TeacherNameRef {
  const TeacherNameRef({required this.id, required this.fullName});

  final int id;
  final String fullName;

  factory TeacherNameRef.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const TeacherNameRef(id: 0, fullName: '');
    }
    return TeacherNameRef(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      fullName: '${json['fullName'] ?? json['full_name'] ?? ''}',
    );
  }
}
