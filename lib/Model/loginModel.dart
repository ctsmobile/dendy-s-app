// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  bool status;
  String message;
  Data? data;
  String? token;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        token: json["token"],
      );
}

class Data {
  int id;
  String? name;
  String? mobile;
  String email;
  String? profile_summary;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.profile_summary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        profile_summary: json["profile_summary"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
