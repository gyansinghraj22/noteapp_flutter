import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class PlatformDialog {
  static showConfirmDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    String confirmText = "OK",
    String? cancelText,
    bool isTop = false,
    bool barrierDismissible = true,
    List<Widget>? actions,
  }) {
    if (isTop == false && ModalRoute.of(context)?.isCurrent != true)
      return null;
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder:
            (contextPop) => CupertinoAlertDialog(
              title: Text(
                title,
                style:
                    context
                        .textStyle(palette: ColorPalete.slate, swatch: 700)
                        .large
                        .semiBold,
              ),
              content: content,
              actions:
                  actions ??
                  [
                    if (cancelText != null)
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(contextPop, false),
                        child: Text(cancelText),
                      ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      isDestructiveAction: false,
                      onPressed: () => Navigator.pop(contextPop, true),
                      child: Text(confirmText),
                    ),
                  ],
            ),
      );
    } else {
      return showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder:
            (contextPop) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                title,
                style:
                    context
                        .textStyle(palette: ColorPalete.slate, swatch: 700)
                        .large
                        .semiBold,
              ),
              content: content,
              actions:
                  actions ??
                  [
                    if (cancelText != null)
                      TextButton(
                        onPressed: () => Navigator.pop(contextPop, false),
                        child: Text(
                          cancelText,
                          style: const TextStyle(
                            color: AppColor.redColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    TextButton(
                      onPressed: () => Navigator.pop(contextPop),
                      child: Text(
                        confirmText,
                        style: const TextStyle(
                          color: AppColor.appThemeColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
            ),
      );
    }
  }

  static showExitDialog({
    required context,
    required routePage,
    String? title,
    String? content,
    String? buttonLabel,
  }) {
    return showConfirmDialog(
      context: context,
      title: title ?? 'Exit',
      content: const Text('Are you sure you want to exit?'),
      actions: [
        CustomDialogButton(
          isDestructiveAction: true,
          label: buttonLabel ?? 'Exit',
          onPressed: () async {
            await Navigator.pushNamedAndRemoveUntil(
              context,
              routePage,
              (route) => false,
            );
          },
        ),
        CustomDialogButton(
          label: "Cancel",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static showInputDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) {
    if (ModalRoute.of(context)?.isCurrent != true) return null;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (contextPop) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              title,
              style:
                  context
                      .textStyle(palette: ColorPalete.slate, swatch: 700)
                      .large
                      .semiBold,
            ),
            content: content,
            actions: const [],
          ),
    );
  }
}
