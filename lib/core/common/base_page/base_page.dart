import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_app_bar/custom_app_bar.dart';

class BasePage extends StatefulWidget {
  final Widget? title;
  final bool? showBackButton;
  final bool? showAppBar;
  final Widget? body;
  final Widget? leadingWidget;
  final List<Widget>? trailing;
  final double? appBarHeight;
  final double? elevation;
  final Color? colors;
  final String? navigate;
  final String? routhPath;
  final Widget? bottom;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? showBottomNav;
  final Color? bodyColor;
  final bool? centerTitle;
  final FloatingActionButtonLocation? fabLocation;

  const BasePage({
    super.key,
    this.title,
    this.showBackButton,
    this.showAppBar,
    this.routhPath,
    this.body,
    this.leadingWidget,
    this.trailing,
    this.appBarHeight,
    this.colors,
    this.elevation,
    this.navigate,
    this.bottom,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.fabLocation,
    this.bodyColor,
    this.showBottomNav,
    this.centerTitle,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: widget.bodyColor ?? Colors.white,
      resizeToAvoidBottomInset: true,
      appBar:
          widget.showAppBar == false
              ? null
              : CustomAppBar(
                centerTitle: widget.centerTitle,
                leadingWidget: widget.leadingWidget,
                elevation: widget.elevation,
                colors: widget.colors ?? AppColor.whiteColor,
                title: widget.title ?? const Text(""),
                showBackButton: widget.showBackButton,
                trailing: widget.trailing,
                height: widget.appBarHeight,
                navigate: widget.navigate,
                bottom: widget.bottom,
              ),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButtonLocation:
          widget.fabLocation ?? FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
