import 'package:meta/meta.dart';
import 'dart:convert';

import '../../../../../core/base/model/base_model.dart';

class SessionResponse extends BaseModel {
  final String accessToken;
  final User user;

  SessionResponse({required this.accessToken, required this.user});

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      SessionResponse(
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
      );

  @override
  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "user": user.toJson(),
  };

  @override
  List<Object?> get props => [accessToken, user];
}

class User extends BaseModel {
  final int id;
  final String role;
  final String fullName;
  final String email;
  final String? phone;
  final Course course;

  User({
    required this.id,
    required this.role,
    required this.fullName,
    required this.email,
    this.phone,
    required this.course,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    role: json["role"],
    fullName: json["fullName"],
    email: json["email"],
    phone: json["phone"],
    course: Course.fromJson(json["course"]),
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "fullName": fullName,
    "email": email,
    "phone": phone,
    "course": course.toJson(),
  };

  @override
  List<Object?> get props => [id, role, fullName, email, phone, course];
}

class Course extends BaseModel {
  final int courseId;
  final String courseRole;
  final String courseName;

  Course({
    required this.courseId,
    required this.courseRole,
    required this.courseName,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    courseId: json["courseId"],
    courseRole: json["courseRole"],
    courseName: json["courseName"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "courseId": courseId,
    "courseRole": courseRole,
    "courseName": courseName,
  };

  @override
  List<Object?> get props => [courseId, courseRole, courseName];
}
