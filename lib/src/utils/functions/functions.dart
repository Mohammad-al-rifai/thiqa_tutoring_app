import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void popScreen(context) => Navigator.of(context).pop();

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

myPrint({required String text}) {
  if (kDebugMode) {
    print(text);
  }
}

int compareTimes(String time1, String time2) {
  final DateFormat format = DateFormat('h:mm a');
  DateTime dateTime1 = format.parse(time1);
  DateTime dateTime2 = format.parse(time2);

  return dateTime1.compareTo(dateTime2);
}

bool isTimeInRange(String targetTime, String fromTime, String toTime) {
  final DateFormat format = DateFormat('h:mm a');
  DateTime targetDateTime = format.parse(targetTime);
  DateTime fromDateTime = format.parse(fromTime);
  DateTime toDateTime = format.parse(toTime);

  return targetDateTime.isAfter(fromDateTime) &&
      targetDateTime.isBefore(toDateTime);
}
