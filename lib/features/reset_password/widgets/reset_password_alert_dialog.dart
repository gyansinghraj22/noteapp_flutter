import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/features/reset_password/bloc/reset_password_bloc.dart';

void showConfirmationDialog(
  BuildContext context,
  Map<String, dynamic> formData,
) {
  final loadingOverlay = GetIt.instance.get<LoadingOverlay>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.alertDialogImage, width: 57, height: 57),
            const SizedBox(height: 15),
            const Text(
              "Are you sure you want to",
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              "Change your password?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButton(
                    buttonPadding: EdgeInsets.zero,
                    onPressed: () {
                      loadingOverlay.show(context);
                      BlocProvider.of<ResetPasswordBloc>(
                        context,
                      ).add(SetResetPasswordEvent(formData: formData));
                      Navigator.pop(context);
                    },
                    labelStyle:
                        context
                            .textStyle(palette: ColorPalete.white)
                            .medium
                            .semiBold,
                    color: context.applyAppColor(palette: ColorPalete.brand),
                    label: 'Yes',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomBorderButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePaths.loginScreen);
                    },
                    labelStyle:
                        context
                            .textStyle(palette: ColorPalete.slate, swatch: 700)
                            .medium
                            .semiBold,
                    borderColor: Colors.transparent,
                    label: 'No',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
