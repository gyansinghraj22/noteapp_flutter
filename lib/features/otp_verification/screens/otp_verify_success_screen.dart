import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class OTPVerifySuccessScreen extends StatefulWidget {
  final String navigatorPath;
  final String? otpNumber;
  const OTPVerifySuccessScreen({
    super.key,
    required this.navigatorPath,
    this.otpNumber,
  });

  @override
  State<OTPVerifySuccessScreen> createState() => _OTPVerifySuccessScreenState();
}

class _OTPVerifySuccessScreenState extends State<OTPVerifySuccessScreen> {
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
                Text(
                  "Create Account",
                  style: context.textStyle(palette: ColorPalete.brand).header3,
                ),
                const SizedBox(height: 4),
                Text(
                  "Fill your information below",
                  style:
                      context
                          .textStyle(palette: ColorPalete.neutral)
                          .medium
                          .semiBold,
                ),
                const SizedBox(height: 16),
                Image.asset(AppImages.successImage, height: 95, width: 95),
                const SizedBox(height: 4),
                Text(
                  "Email Verified",
                  style: context.textStyle(palette: ColorPalete.brand).header3,
                ),
                const SizedBox(height: 2),
                Text(
                  "Your email has been successfully verified.\nPlease click below to continue.",
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
                    if (widget.navigatorPath ==
                        RoutePaths.resetPasswordScreen) {
                      Navigator.pushNamed(
                        context,
                        widget.navigatorPath,
                        arguments: {'otpNumber': widget.otpNumber},
                      );
                    }
                    Navigator.pushNamed(context, widget.navigatorPath);
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
