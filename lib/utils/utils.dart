// ignore_for_file: unnecessary_new

import 'package:intl/intl.dart';

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

List names = [
  'System Cleaning',
  'Filter Cleaning',
  'System Exchange',
  'Filter Cleaning',
];
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
