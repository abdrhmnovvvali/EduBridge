/// Sinif qısa məlumatı (class: { id, name }).
class ClassNameRef {
  const ClassNameRef({required this.id, required this.name});

  final int id;
  final String name;

  factory ClassNameRef.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ClassNameRef(id: 0, name: '');
    }
    return ClassNameRef(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: '${json['name'] ?? json['className'] ?? ''}',
    );
  }
}
