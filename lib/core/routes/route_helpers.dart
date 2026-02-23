import 'package:flutter/material.dart';

class RouteHelpers {
  static void pushRemoveRoute(BuildContext? context, String path) {
    Navigator.of(context!)
        .pushNamedAndRemoveUntil(path, (Route<dynamic> route) => false);
  }
}
