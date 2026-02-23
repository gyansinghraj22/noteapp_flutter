import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class ResetPasswordSuccessScreen extends StatefulWidget {
  const ResetPasswordSuccessScreen({super.key});

  @override
  State<ResetPasswordSuccessScreen> createState() =>
      _ResetPasswordSuccessScreenState();
}

class _ResetPasswordSuccessScreenState
    extends State<ResetPasswordSuccessScreen> {
  TextEditingController otpController = TextEditingController();
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: Iconoir.ArrowLeft(
                //       width: 24,
                //       height: 24,
                //       color: context.applyAppColor(palette: ColorPalete.brand),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 25),
                Image.asset(AppImages.successImage, height: 95, width: 95),
                const SizedBox(height: 4),
                Text(
                  "Password Changed!",
                  style: context.textStyle(palette: ColorPalete.brand).header3,
                ),
                const SizedBox(height: 2),
                Text(
                  "Your password has been successfully changed.\nPlease click below to continue.",
                  textAlign: TextAlign.center,
                  style:
                      context
                          .textStyle(palette: ColorPalete.neutral)
                          .small
                          .semiBold,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.loginScreen);
                  },
                  height: 55,
                  labelStyle:
                      context
                          .textStyle(palette: ColorPalete.white)
                          .xlarge
                          .semiBold,
                  color: context.applyAppColor(palette: ColorPalete.brand),
                  buttonPadding: const EdgeInsets.only(left: 28, right: 28),
                  label: "Continue",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
