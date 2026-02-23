import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class ShowDialog {
  final BuildContext context;

  ShowDialog({required this.context});

  void showErrorStateDialog({String? title, String? body, Function()? onTab}) {
    if (ModalRoute.of(context)?.isCurrent != true) {
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? 'Error',
                  style: context.textStyle(palette: ColorPalete.red).header5,
                ),
                const Divider(thickness: 2),
                Text(
                  body == null || body.isEmpty
                      ? "Something went wrong. Please try again."
                      : body,
                  textAlign: TextAlign.center,
                  style:
                      context
                          .textStyle(palette: ColorPalete.slate, swatch: 700)
                          .medium
                          .regular,
                ),
                const SizedBox(height: 15),
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        right: 8,
                        left: 8,
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: onTab ?? () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style:
                        context
                            .textStyle(palette: ColorPalete.brand)
                            .large
                            .semiBold,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void showCustomDialog({
    required String title,
    required String body,
    Widget? action,
    Function()? onTab,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style:
                    dialogContext.textStyle(palette: ColorPalete.red).header5,
              ),
              const Divider(thickness: 2),
              Text(
                body,
                textAlign: TextAlign.center,
                style:
                    dialogContext
                        .textStyle(palette: ColorPalete.slate, swatch: 700)
                        .medium
                        .regular,
              ),
              const SizedBox(height: 15),
              action ??
                  TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 8,
                          left: 8,
                        ),
                      ),
                      minimumSize: WidgetStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: onTab ?? () => Navigator.pop(dialogContext),
                    child: Text(
                      "OK",
                      style:
                          dialogContext
                              .textStyle(palette: ColorPalete.brand)
                              .large
                              .semiBold,
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
