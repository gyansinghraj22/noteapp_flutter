import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerUtils {
  static bool isLeapYear(int year) {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    } else {
      return true;
    }
  }

  static DateTime getYearFormNow() {
    DateTime date = DateTime.now();
    DateTime _maximumDate = DateTime(date.year - 18, date.month, date.day);
    return _maximumDate;
  }

  static DateTime showInitialDate(
      {required String value, required String keyName}) {
    if (keyName == "date_of_birth" && value == '') {
      return getYearFormNow();
    } else if (value == "") {
      return DateTime.now();
    } else {
      return DateTime.parse(
        value,
      );
    }
  }

  static DateTime showLastDate(
      {required String keyName, required BuildContext context}) {
    if (keyName == "date_of_birth") {
      return DateTime.now();
    } else {
      return DateTime.utc(2045);
    }
  }

  static int validateDate() {
    final now = DateTime.now();
    final lastDate = now.year - 0016;

    return lastDate;
  }

  static DateTime getNextWeekday(DateTime currentDate, int weekday) {
    int daysToAdd = weekday - currentDate.weekday;
    if (daysToAdd <= 0) {
      daysToAdd -= 7;
    }
    return currentDate.add(Duration(days: daysToAdd));
  }

  static DateTime showFirstDate(
      {required String keyName,
      required BuildContext context,
      TextEditingController? controller}) {
    if (keyName == "date_of_birth") {
      return DateTime.utc(1920);
    } else {
      return DateTime.utc(1920);
    }
  }

  static String formatDate(dynamic date) {
    if (date is DateTime) {
      final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
      return serverFormatter.format(date);
    } else if (date is String) {
      final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
      return serverFormatter.format(DateTime.parse(date));
    } else {
      final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
      return serverFormatter.format(DateTime.parse(date));
    }
  }
}
