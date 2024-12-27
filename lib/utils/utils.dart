// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:dendy_app/utils/appcolors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static double? width;
  static double? height;
}

const String baseImagePath = 'assets/images/';
const String welcomeText =
    "Dendy’s Hood Cleaning Services, LLC. of Upstate, SC is the leading CERTIFIED commercial kitchen Hood Exhaust cleaning and maintenance company that serves a variety of industries. As a full-service business, we offer numerous cleaning services to ensure your business meets compliance with local regulations.";
String getSystemTime() {
  var now = new DateTime.now();
  return new DateFormat("HH : mm : ss").format(now);
}

const String baseUrl = 'https://dendyapp.chawtechsolutions.ch/api/';
bool checkSameDate(String date) {
  print("date$date");
  // Parse the given date string into a DateTime object
  DateTime parsedGivenDate = DateTime.parse(
    "${date.split(':')[2]}-${date.split(':')[1]}-${date.split(':')[0]}",
  );

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Check if the current date is the same as the given date
  bool isSameDate = parsedGivenDate.year == currentDate.year &&
      parsedGivenDate.month == currentDate.month &&
      parsedGivenDate.day == currentDate.day;

  return isSameDate;
}

String getTimeFromDate(String date) {
  // Parse the string into a DateTime object
  DateTime dateTime = DateTime.parse(date);

  // Extract the time (hours, minutes, seconds)
  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  return formattedTime.toString().split(':').sublist(0, 2).join(':');
}

String getTimeDifference(String startDate) {
  // Given date string

  // Parse the given date string into a DateTime object
  DateTime givenDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startDate);

  // Get the current date and time
  DateTime currentDate = DateTime.now();

  // Calculate the difference between the two dates
  Duration difference = currentDate.difference(givenDate);

  // Extract hours, minutes, and seconds from the Duration
  // int days = difference.inDays;
  int days = 0;
  print('days$days');
  int hours = difference.inHours.remainder(12);
  int minutes = difference.inMinutes.remainder(60);
  int seconds = difference.inSeconds.remainder(60);

  // Format the time difference as HH:mm:ss
  String formattedDifference =
      '${days.toString().padLeft(2, '0')} days ${hours.toString().padLeft(2, '0')} Hours ${minutes.toString().padLeft(2, '0')} Min ${seconds.toString().padLeft(2, '0')} Sec';
  // '${hours.toString().padLeft(2, '0')} : '
  //     '${minutes.toString().padLeft(2, '0')} : '
  //     '${seconds.toString().padLeft(2, '0')}';

  return formattedDifference;
}

String converter24To12(String time24Hour) {
  // Parse the 24-hour format string to a DateTime object
  DateTime dateTime = DateFormat("HH:mm:ss").parse(time24Hour);

  // Format the DateTime object to a 12-hour format with AM/PM
  String time12Hour = DateFormat("h:mm a").format(dateTime);

  return time12Hour; // Output: 6:55 PM
}

Future<void> requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();

  if (status.isGranted) {
    print('Permission granted to access storage.');
  } else if (status.isDenied) {
    print('Permission denied.');
    openAppSettings();
  } else if (status.isPermanentlyDenied) {
    // If the permission is permanently denied, direct the user to the app settings
    openAppSettings();
  }
}

showSnackBar(String message,
    {Color backgroundColor = redColor, String? titleText}) {
  if (!Get.isSnackbarOpen) {
    Get.snackbar('', message,
        backgroundColor: backgroundColor,
        titleText: titleText != null
            ? Text(
                titleText,
                style:
                    TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
              )
            : SizedBox.shrink(),
        dismissDirection: DismissDirection.horizontal,
        colorText: whiteColor);
  }
}

void launchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
