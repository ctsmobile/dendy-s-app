// To parse this JSON data, do
//
//     final pendingJobListModel = pendingJobListModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

PendingJobListModel pendingJobListModelFromJson(String str) =>
    PendingJobListModel.fromJson(json.decode(str));

class PendingJobListModel {
  bool status;
  String? message;
  List<PendingJobs> pendingJob;

  PendingJobListModel({
    required this.status,
    required this.message,
    required this.pendingJob,
  });

  factory PendingJobListModel.fromJson(Map<String, dynamic> json) {
    print("aas${json["data"]}");
    return PendingJobListModel(
      status: json["status"] ?? false,
      message: json["message"],
      pendingJob: (json["data"] == null || json["data"].isEmpty)
          ? []
          : List<PendingJobs>.from(
              json["data"].map((x) => PendingJobs.fromJson(x))),
    );
  }
}

class PendingJobs {
  int id;
  String? name;
  String? date;
  int? team_lead;
  String? time;
  int customerId;
  String? jobLocation;
  String? job_end_time;
  String? jobLat;
  String? jobLng;
  String? status;
  DateTime createdAt;
  dynamic updatedAt;
  Customer customer;
  List<Task> tasks;
  List<User> employees;

  PendingJobs({
    required this.id,
    required this.name,
    required this.team_lead,
    required this.job_end_time,
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
    required this.employees,
  });

  factory PendingJobs.fromJson(Map<String, dynamic> json) => PendingJobs(
        id: json["id"],
        name: json["name"],
        team_lead: json["team_lead"],
        date: json["date"] == null
            ? null
            : DateFormat('MM/dd/yyyy').format(DateTime.parse(json["date"])),
        job_end_time: json["job_end_time"] == null
            ? null
            : DateFormat('MM/dd/yyyy')
                .format(DateTime.parse(json["job_end_time"])),
        time: json["time"],
        customerId: json["customer_id"],
        jobLocation: json["job_location"],
        jobLat: json["job_lat"],
        jobLng: json["job_lng"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
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

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.location,
    required this.lat,
    required this.lng,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
      );
}

class Task {
  int id;
  int jobId;
  String? taskName;
  DateTime createdAt;
  DateTime? updatedAt;

  Task({
    required this.id,
    required this.jobId,
    required this.taskName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        jobId: json["job_id"],
        taskName: json["task_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "task_name": taskName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  int id;
  int jobId;
  int employeeId;
  int crewLead;
  int request_status;
  dynamic createdAt;
  dynamic updatedAt;
  Jobuser? jobuser;

  User({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.crewLead,
    required this.request_status,
    required this.createdAt,
    required this.updatedAt,
    required this.jobuser,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      jobId: json["job_id"],
      employeeId: json["employee_id"],
      crewLead: json["crew_lead"],
      request_status: json["request_status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      jobuser:
          json["jobuser"] == null ? null : Jobuser.fromJson(json["jobuser"]));
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
