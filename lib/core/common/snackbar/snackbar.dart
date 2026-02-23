import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';

showSuccessSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: AppColor.successColor,
      padding: const EdgeInsets.only(left: 16),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
          //todo task
        },
      ),
      onVisible: () {
        //todo task
      },
    ),
  );
}

showErrorSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: AppColor.errorColor,
      padding: const EdgeInsets.only(left: 16),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
          //todo task
        },
      ),
      onVisible: () {
        //todo task
      },
    ),
  );
}

showAppExistSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text("Click once more to exit app"),
      backgroundColor: AppColor.appThemeColor,
      padding: const EdgeInsets.only(left: 16),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.black,
        onPressed: () {
          //todo task
        },
      ),
      onVisible: () {
        //todo task
      },
    ),
  );
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: AppColor.appThemeColor,
      padding: const EdgeInsets.only(left: 16),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
          //todo task
        },
      ),
      onVisible: () {
        //todo tasks
      },
    ),
  );
}
