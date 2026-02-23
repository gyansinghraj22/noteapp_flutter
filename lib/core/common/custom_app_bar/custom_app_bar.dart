import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? showBackButton;
  final Widget? child;
  final Widget? leadingWidget;
  final List<Widget>? trailing;
  final double? height;
  final double? elevation;
  final Color? colors;
  final Widget? title;
  final String? navigate;
  final Widget? bottom;
  final Color? appBarColor;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton,
    this.child,
    this.leadingWidget,
    this.trailing,
    this.height,
    this.elevation,
    this.colors,
    this.navigate,
    this.bottom,
    this.appBarColor,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: AppColor.blackColor),
      elevation: elevation ?? 0.5,
      backgroundColor: colors ?? AppColor.whiteColor,
      centerTitle: centerTitle ?? false,
      title: title,
      shadowColor: AppColor.whiteColor,
      leading:
          showBackButton == false
              ? leadingWidget
              : Builder(
                builder:
                    (BuildContext context) => IconButton(
                      onPressed: () {
                        navigate != null
                            ? Navigator.pushNamed(context, navigate!)
                            : WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                      },
                      icon: leadingWidget ?? AppIcons.arrowBack,
                    ),
              ),
      actions: trailing ?? [const Text('')],
      bottom:
          bottom == null
              ? null
              : PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: bottom ?? const Text(''),
              ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
