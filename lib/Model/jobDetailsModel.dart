// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

JobDetailsModel jobDetailsModelFromJson(String str) =>
    JobDetailsModel.fromJson(json.decode(str));

class JobDetailsModel {
  bool status;
  String message;
  Data data;
  Error error;

  JobDetailsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) =>
      JobDetailsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        error: Error.fromJson(json["error"]),
      );
}

class Data {
  int id;
  String jobNumber;
  String name;
  String? date;
  String time;
  int customerId;
  String jobLocation;
  dynamic jobLat;
  dynamic jobLng;
  String status;
  int teamLead;
  DateTime? jobStartTime;
  DateTime jobEndTime;
  String spentTime;
  DateTime createdAt;
  DateTime updatedAt;
  Customer customer;
  List<Task> tasks;
  List<Employees> employees;
  List<Image> startimage;
  List<Image> endimage;

  Data({
    required this.id,
    required this.jobNumber,
    required this.name,
    required this.date,
    required this.time,
    required this.customerId,
    required this.jobLocation,
    required this.jobLat,
    required this.jobLng,
    required this.status,
    required this.teamLead,
    required this.jobStartTime,
    required this.jobEndTime,
    required this.spentTime,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.tasks,
    required this.startimage,
    required this.endimage,
    required this.employees,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    try {
      return Data(
        id: json["id"],
        jobNumber: json["job_number"],
        name: json["name"],
        date: json["date"] == null
            ? null
            : DateFormat('dd-MM-yyyy').format(DateTime.parse(json["date"])),
        time: json["time"],
        customerId: json["customer_id"],
        jobLocation: json["job_location"],
        jobLat: json["job_lat"],
        jobLng: json["job_lng"],
        status: json["status"],
        teamLead: json["team_lead"],
        jobStartTime: json["job_start_time"] == null
            ? null
            : DateTime.parse(json["job_start_time"]),
        jobEndTime: DateTime.parse(json["job_end_time"]),
        spentTime: json["spent_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customer: Customer.fromJson(json["customer"]),
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
        startimage:
            List<Image>.from(json["startimage"].map((x) => Image.fromJson(x))),
        endimage:
            List<Image>.from(json["endimage"].map((x) => Image.fromJson(x))),
        employees: List<Employees>.from(
            json["employees"].map((x) => Employees.fromJson(x))),
      );
    } catch (e) {
      print("object${e.toString()}");
      throw Exception("Failed to parse Data from JSON");
    }
  }
}

class Task {
  int id;
  int jobId;
  String taskName;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

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
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "task_name": taskName,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Image {
  int id;
  String jobId;
  String employeeId;
  String imageUrl;
  dynamic createdAt;
  dynamic updatedAt;

  Image({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        jobId: json["job_id"],
        employeeId: json["employee_id"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "employee_id": employeeId,
        "image_url": imageUrl,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Employees {
  int id;
  int jobId;
  int employeeId;
  int crewLead;
  dynamic createdAt;
  dynamic updatedAt;
  Jobuser jobuser;

  Employees({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.crewLead,
    required this.createdAt,
    required this.updatedAt,
    required this.jobuser,
  });

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
        id: json["id"],
        jobId: json["job_id"],
        employeeId: json["employee_id"],
        crewLead: json["crew_lead"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        jobuser: Jobuser.fromJson(json["jobuser"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "employee_id": employeeId,
        "crew_lead": crewLead,
        "created_at": createdAt,
        "jobuser": jobuser.toJson(),
        "updated_at": updatedAt,
      };
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

class Customer {
  int id;
  String name;
  String email;
  String contactNumber;
  String location;
  dynamic lat;
  dynamic lng;
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

class Startimage {
  int id;
  String jobId;
  String employeeId;
  String imageUrl;
  dynamic createdAt;
  dynamic updatedAt;

  Startimage({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Startimage.fromJson(Map<String, dynamic> json) => Startimage(
        id: json["id"],
        jobId: json["job_id"],
        employeeId: json["employee_id"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "employee_id": employeeId,
        "image_url": imageUrl,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Error {
  Error();

  factory Error.fromJson(Map<String, dynamic> json) => Error();

  Map<String, dynamic> toJson() => {};
}
