import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_padding.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.title,
    this.leading,
    this.onPress,
    this.trailing,
    this.subTitle,
    this.leadingHeight,
    this.leadingWidth,
  });

  final Widget? leading;
  final Widget? trailing;
  final double? leadingHeight;
  final double? leadingWidth;
  final Function()? onPress;
  final Widget? title;
  final Widget? subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: AppPadding.listTilePadding,
      dense: true,
      onTap: onPress,
      leading:
          leading != null
              ? SizedBox(
                height: leadingHeight ?? 25,
                width: leadingWidth ?? 50,
                child: leading,
              )
              : null,
      title: title ?? const Text("Title"),
      trailing: trailing,
      subtitle: subTitle,
    );
  }
}
