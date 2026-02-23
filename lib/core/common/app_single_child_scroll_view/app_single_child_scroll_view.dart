import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppSingleChildScrollView extends StatelessWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  ScrollController? controller;
  AppSingleChildScrollView(
      {super.key, required this.child, this.onRefresh, this.controller});

  @override
  Widget build(BuildContext context) {
    return onRefresh != null
        ? RefreshIndicator(
            onRefresh: onRefresh!,
            child: SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: child,
            ),
          )
        : SingleChildScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            child: child,
          );
  }
}
