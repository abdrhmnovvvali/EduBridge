class CreateSessionParams {
  final int classId;
  final DateTime startsAt;
  final DateTime endsAt;

  CreateSessionParams({
    required this.classId,
    required this.startsAt,
    required this.endsAt,
  });

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "startsAt": startsAt.toIso8601String(),
        "endsAt": endsAt.toIso8601String(),
      };
}
