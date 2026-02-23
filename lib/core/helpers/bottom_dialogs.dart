import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class BottomDialog {
  static Future<void> showBottomDialog({
    required BuildContext context,
    required Widget child,
    String? title = "",
  }) {
    return showModalBottomSheet<void>(
      enableDrag: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext popContext) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 0),
          curve: Curves.decelerate,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != "")
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.appThemeColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title!,
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.slate,
                                swatch: 700,
                              )
                              .large
                              .semiBold,
                    ),
                  ),
                ),
              child,
            ],
          ),
        );
      },
    );
  }
}
