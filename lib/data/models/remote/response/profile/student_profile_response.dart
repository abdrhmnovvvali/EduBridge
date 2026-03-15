import 'dart:convert';
import '../../../../../core/base/model/base_model.dart';

class StudentProfileResponse extends BaseModel {
  final int id;
  final String role;
  final String fullName;
  final String? phone;
  final String email;
  final String? photoUrl;
  final String status;
  final String? specialty;
  final DateTime createdAt;
  final double totalMonthlyFee;
  final double attendancePercentage;
  final List<Enrollment> enrollments;

  StudentProfileResponse({
    required this.id,
    required this.role,
    required this.fullName,
    this.phone,
    required this.email,
    this.photoUrl,
    required this.status,
    this.specialty,
    required this.createdAt,
    required this.totalMonthlyFee,
    required this.attendancePercentage,
    required this.enrollments,
  });

  factory StudentProfileResponse.empty() => StudentProfileResponse(
        id: 0,
        role: '',
        fullName: '',
        email: '',
        status: '',
        createdAt: DateTime.now(),
        totalMonthlyFee: 0,
        attendancePercentage: 0,
        enrollments: [],
      );

  factory StudentProfileResponse.fromRawJson(String str) =>
      StudentProfileResponse.fromJson(json.decode(str));

  factory StudentProfileResponse.fromJson(Map<String, dynamic> json) =>
      StudentProfileResponse(
        id: json["id"],
        role: json["role"],
        fullName: json["full_name"],
        phone: json["phone"],
        email: json["email"],
        photoUrl: json["photo_url"],
        status: json["status"],
        specialty: json["specialty"],
        createdAt: DateTime.parse(json["created_at"]),
        totalMonthlyFee:
            (json["totalMonthlyFee"] != null) ? (json["totalMonthlyFee"] as num).toDouble() : 0,
        attendancePercentage: (json["attendancePercentage"] != null)
            ? (json["attendancePercentage"] as num).toDouble()
            : 0,
        enrollments: json["enrollments"] == null
            ? []
            : List<Enrollment>.from(
                json["enrollments"].map((x) => Enrollment.fromJson(x)),
              ),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "full_name": fullName,
        "phone": phone,
        "email": email,
        "photo_url": photoUrl,
        "status": status,
        "specialty": specialty,
        "created_at": createdAt.toIso8601String(),
        "totalMonthlyFee": totalMonthlyFee,
        "attendancePercentage": attendancePercentage,
        "enrollments": enrollments.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        role,
        fullName,
        phone,
        email,
        photoUrl,
        status,
        specialty,
        createdAt,
        totalMonthlyFee,
        attendancePercentage,
        enrollments,
      ];
}

class Enrollment extends BaseModel {
  final int classId;
  final String className;
  final String courseName;
  final DateTime startDate;
  final DateTime endDate;
  final double monthlyFee;

  Enrollment({
    required this.classId,
    required this.className,
    required this.courseName,
    required this.startDate,
    required this.endDate,
    required this.monthlyFee,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
        classId: json["classId"],
        className: json["className"],
        courseName: json["courseName"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        monthlyFee: (json["monthlyFee"] != null) ? (json["monthlyFee"] as num).toDouble() : 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "classId": classId,
        "className": className,
        "courseName": courseName,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "monthlyFee": monthlyFee,
      };

  @override
  List<Object?> get props => [
        classId,
        className,
        courseName,
        startDate,
        endDate,
        monthlyFee,
      ];
}