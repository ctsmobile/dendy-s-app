// To parse this JSON data, do
//
//     final activeJobModel = activeJobModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ActiveJobModel activeJobModelFromJson(String str) =>
    ActiveJobModel.fromJson(json.decode(str));

class ActiveJobModel {
  bool status;
  String message;
  List<Datum> data;
  Error error;

  ActiveJobModel({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory ActiveJobModel.fromJson(Map<String, dynamic> json) => ActiveJobModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: Error.fromJson(json["error"]),
      );
}

class Datum {
  int id;
  String name;
  DateTime date;
  String time;
  int customerId;
  String jobLocation;
  String jobLat;
  String jobLng;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Customer customer;
  List<Task> tasks;
  List<User> users;

  Datum({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.customerId,
    required this.jobLocation,
    required this.jobLat,
    required this.jobLng,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.tasks,
    required this.users,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        customerId: json["customer_id"],
        jobLocation: json["job_location"],
        jobLat: json["job_lat"],
        jobLng: json["job_lng"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customer: Customer.fromJson(json["customer"]),
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );
}

class Customer {
  int id;
  String name;
  String email;
  String contactNumber;
  String location;
  String lat;
  String lng;
  String? createdAt;
  String? updatedAt;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.location,
    required this.lat,
    required this.lng,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
        createdAt: json["created_at"] == null
            ? null
            : DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(json["created_at"])),
        updatedAt: json["updated_at"] == null
            ? null
            : DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(json["updated_at"])),
      );
}

class Task {
  int id;
  int jobId;
  String taskName;
  int status;
  DateTime createdAt;
  dynamic updatedAt;

  Task({
    required this.id,
    required this.jobId,
    required this.taskName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        jobId: json["job_id"],
        taskName: json["task_name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "task_name": taskName,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}

class User {
  int id;
  int jobId;
  int employeeId;
  int crewLead;
  dynamic createdAt;
  dynamic updatedAt;

  User({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.crewLead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        jobId: json["job_id"],
        employeeId: json["employee_id"],
        crewLead: json["crew_lead"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "employee_id": employeeId,
        "crew_lead": crewLead,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Error {
  Error();

  factory Error.fromJson(Map<String, dynamic> json) => Error();

  Map<String, dynamic> toJson() => {};
}
