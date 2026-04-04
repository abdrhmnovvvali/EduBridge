class CreateTaskParams {
  final int classId;
  final String title;
  final String? description;
  final DateTime? dueAt;

  CreateTaskParams({
    required this.classId,
    required this.title,
    this.description,
    this.dueAt,
  });

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "title": title,
        if (description != null) "description": description,
        if (dueAt != null) "dueAt": dueAt!.toIso8601String(),
      };
}
