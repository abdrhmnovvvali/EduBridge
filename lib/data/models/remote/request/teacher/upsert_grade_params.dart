class UpsertGradeParams {
  final int studentUserId;
  final int classId;
  final String dateKey;
  final double value;
  final String? note;
  final String scope;

  UpsertGradeParams({
    required this.studentUserId,
    required this.classId,
    required this.dateKey,
    required this.value,
    this.note,
    this.scope = 'daily',
  });

  Map<String, dynamic> toJson() => {
        "studentUserId": studentUserId,
        "classId": classId,
        "dateKey": dateKey,
        "value": value,
        if (note != null) "note": note,
        "scope": scope,
      };
}
