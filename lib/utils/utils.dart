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
