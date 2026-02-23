import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class AuthenticateFooterView extends StatefulWidget {
  final String routePath;
  const AuthenticateFooterView({super.key, required this.routePath});

  @override
  State<AuthenticateFooterView> createState() => _AuthenticateFooterViewState();
}

class _AuthenticateFooterViewState extends State<AuthenticateFooterView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120.w,
              child: Divider(
                color: context.applyAppColor(
                  palette: ColorPalete.neutral,
                  swatch: 400,
                ),
                thickness: 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Or",
                style:
                    context
                        .textStyle(palette: ColorPalete.brand, swatch: 400)
                        .medium
                        .regular,
              ),
            ),
            SizedBox(
              width: 120.w,
              child: Divider(
                color: context.applyAppColor(
                  palette: ColorPalete.neutral,
                  swatch: 400,
                ),
                thickness: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // buildOtherMethodForSignup(),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.routePath == "loginScreen"
                  ? "Don’t have an account?"
                  : "Already have an account?",
              style: context.textBlackStyle().small.regular,
            ),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
                ),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                widget.routePath == "loginScreen"
                    ? Navigator.pushNamed(context, RoutePaths.signupScreen)
                    : Navigator.pushNamed(context, RoutePaths.loginScreen);
              },
              child: Text(
                widget.routePath == "loginScreen" ? "Sign Up  " : "Log In  ",
                style: context
                    .textStyle(palette: ColorPalete.brand, swatch: 500)
                    .xsmall
                    .regular
                    .copyWith(
                      decorationThickness: 1,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
        // GestureDetector(
        //   onTap: () {
        //     widget.routePath == "loginScreen"
        //         ? Navigator.pushNamed(context, RoutePaths.signupScreen)
        //         : Navigator.pushNamed(context, RoutePaths.loginScreen);
        //   },
        //   child: RichText(
        //     text: TextSpan(
        //       text: "Don’t have an account? ",
        //       style: context.textBlackStyle().small.regular,
        //       children: [
        //         TextSpan(
        //           text: widget.routePath == "loginScreen"
        //               ? " Sign Up  "
        //               : " Log In  ",
        //           style: context
        //               .textStyle(palette: ColorPalete.brand)
        //               .small
        //               .regular
        //               .copyWith(
        //                 decoration: TextDecoration.underline,
        //               ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // buildOtherMethodForSignup() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       _socialButton(AppImages.appleImage, () {
  //         // Handle Apple sign-in
  //       }, "Continue with Apple"),
  //       SizedBox(height: 8.h),
  //       _socialButton(AppImages.facebookImage, () {
  //         // Handle Facebook sign-in
  //       }, "Continue with Facebook"),
  //       SizedBox(height: 8.h),
  //       _socialButton(AppImages.googleImage, () {
  //         // Handle Google sign-in
  //       }, "Continue with Google"),
  //     ],
  //   );
  // }

  // Widget _socialButton(String assetPath, VoidCallback? onTap, String label) {
  //   return SizedBox(
  //     width: double.infinity,
  //     child: OutlinedButton.icon(
  //       style: OutlinedButton.styleFrom(
  //         foregroundColor: Colors.black54,
  //         side: const BorderSide(color: Colors.black26),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
  //       ),
  //       icon: Image.asset(assetPath, height: 24, width: 24),
  //       label: Text(label),
  //       onPressed: onTap,
  //     ),
  //   );
  // }
}
