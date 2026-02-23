import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class CustomTitleBottomSheet extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final Widget child;
  final bool showCrossIcon;

  const CustomTitleBottomSheet({
    super.key,
    this.title = "Select",
    required this.child,
    this.showCrossIcon = true,
    this.titleStyle,
  });

  @override
  State<CustomTitleBottomSheet> createState() => _CustomTitleBottomSheetState();
}

class _CustomTitleBottomSheetState extends State<CustomTitleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 32, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style:
                      context
                          .textStyle(palette: ColorPalete.slate, swatch: 700)
                          .header5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style:
                        context
                            .textStyle(palette: ColorPalete.slate, swatch: 700)
                            .large
                            .semiBold,
                  ),
                ),
              ],
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}
