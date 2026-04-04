import 'dart:convert';
import '../../../../../core/base/model/base_model.dart';

class TeacherProfileResponse extends BaseModel {
  final int id;
  final String role;
  final String fullName;
  final String email;
  final String? phone;
  final String? photoUrl;
  final String status;
  final String? specialty;
  final DateTime createdAt;
  final Course? course;
  final List<TeacherClass> classes;

  TeacherProfileResponse({
    required this.id,
    required this.role,
    required this.fullName,
    required this.email,
    this.phone,
    this.photoUrl,
    required this.status,
    this.specialty,
    required this.createdAt,
    this.course,
    required this.classes,
  });

  factory TeacherProfileResponse.empty() => TeacherProfileResponse(
    id: 0,
    role: '',
    fullName: '',
    email: '',
    status: '',
    createdAt: DateTime.now(),
    classes: [],
  );

  factory TeacherProfileResponse.fromRawJson(String str) =>
      TeacherProfileResponse.fromJson(json.decode(str));

  factory TeacherProfileResponse.fromJson(Map<String, dynamic> json) =>
      TeacherProfileResponse(
        id: json["id"],
        role: json["role"],
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        photoUrl: json["photo_url"],
        status: json["status"],
        specialty: json["specialty"],
        createdAt: DateTime.parse(json["createdAt"]),
        course: json["course"] != null ? Course.fromJson(json["course"]) : null,
        classes: json["classes"] == null
            ? []
            : List<TeacherClass>.from(
                json["classes"].map((x) => TeacherClass.fromJson(x)),
              ),
      );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "full_name": fullName,
    "email": email,
    "phone": phone,
    "photo_url": photoUrl,
    "status": status,
    "specialty": specialty,
    "createdAt": createdAt.toIso8601String(),
    "course": course?.toJson(),
    "classes": classes.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    id,
    role,
    fullName,
    email,
    phone,
    photoUrl,
    status,
    specialty,
    createdAt,
    course,
    classes,
  ];
}

class TeacherClass extends BaseModel {
  final int id;
  final String name;
  final String number;
  final String specialization;
  final String courseName;

  TeacherClass({
    required this.id,
    required this.name,
    required this.number,
    required this.specialization,
    required this.courseName,
  });

  factory TeacherClass.fromJson(Map<String, dynamic> json) => TeacherClass(
    id: json["id"],
    name: json["name"] ?? "",
    number: json["number"] ?? "",
    specialization: json["specialization"] ?? "",
    courseName: json["courseName"] ?? json["course_name"] ?? "",
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "number": number,
    "specialization": specialization,
    "courseName": courseName,
  };

  @override
  List<Object?> get props => [id, name, number, specialization, courseName];
}

class Course extends BaseModel {
  final int courseId;
  final String courseName;
  final DateTime startDate;
  final DateTime endDate;

  Course({
    required this.courseId,
    required this.courseName,
    required this.startDate,
    required this.endDate,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    courseId: json["courseId"],
    courseName: json["courseName"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
  );

  @override
  Map<String, dynamic> toJson() => {
    "courseId": courseId,
    "courseName": courseName,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
  };

  @override
  List<Object?> get props => [courseId, courseName, startDate, endDate];
}
