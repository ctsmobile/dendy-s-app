// To parse this JSON data, do
//
//     final activeJobModel = activeJobModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:intl/intl.dart';

ActiveJobModel activeJobModelFromJson(String str) =>
    ActiveJobModel.fromJson(json.decode(str));

class ActiveJobModel {
  bool status;
  String message;
  List<ActiveJob> data;

  ActiveJobModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ActiveJobModel.fromJson(Map<String, dynamic> json) => ActiveJobModel(
        status: json["status"] ?? false,
        message: json["message"].toString(),
        data: (json["data"] == null || json["data"].isEmpty)
            ? []
            : List<ActiveJob>.from(
                json["data"].map((x) => ActiveJob.fromJson(x))),
      );
}

class ActiveJob {
  int id;
  String? name;
  String? date;
  String? time;
  int customerId;
  String? jobLocation;
  int? team_lead;
  String? job_start_time;
  String? jobLat;
  String? jobLng;
  String? status;
  DateTime createdAt;
  DateTime updatedAt;
  Customer customer;
  List<Task> tasks;
  List<User> employees;

  ActiveJob({
    required this.id,
    required this.name,
    required this.date,
    required this.team_lead,
    required this.time,
    required this.customerId,
    required this.jobLocation,
    required this.job_start_time,
    required this.jobLat,
    required this.jobLng,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.tasks,
    required this.employees,
  });

  factory ActiveJob.fromJson(Map<String, dynamic> json) => ActiveJob(
        id: json["id"],
        name: json["name"],
        team_lead: json["team_lead"],
        date: json["date"] == null
            ? null
            : DateFormat('dd-MM-yyyy').format(DateTime.parse(json["date"])),
        time: json["time"],
        customerId: json["customer_id"],
        jobLocation: json["job_location"],
        job_start_time: json["job_start_time"],
        jobLat: json["job_lat"],
        jobLng: json["job_lng"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customer: Customer.fromJson(json["customer"]),
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
        employees:
            List<User>.from(json["employees"].map((x) => User.fromJson(x))),
      );
}

class Customer {
  int id;
  String? name;
  String? email;
  String? contactNumber;
  String? location;
  String? lat;
  String? lng;
  String? createdAt;
  String? wholeCreatedAt;
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
    required this.wholeCreatedAt,
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
        wholeCreatedAt: json["created_at"].toString(),
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
  String? taskName;
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
  Jobuser? jobuser;

  User({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.crewLead,
    required this.createdAt,
    required this.updatedAt,
    required this.jobuser,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        jobId: json["job_id"],
        employeeId: json["employee_id"],
        crewLead: json["crew_lead"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        jobuser:
            json["jobuser"] == null ? null : Jobuser.fromJson(json["jobuser"]),
      );
}

class Jobuser {
  int id;
  String name;

  Jobuser({
    required this.id,
    required this.name,
  });

  factory Jobuser.fromJson(Map<String, dynamic> json) => Jobuser(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Error {
  Error();

  factory Error.fromJson(Map<String, dynamic> json) => Error();

  Map<String, dynamic> toJson() => {};
}
