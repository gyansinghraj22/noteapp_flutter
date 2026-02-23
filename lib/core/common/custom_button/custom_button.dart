// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
// import 'package:noteapp/constants/app_colors.dart';
// import 'package:noteapp/constants/app_padding.dart';
// import 'package:noteapp/core/extention/color_extention.dart';
// import 'package:noteapp/core/typography/font_style_extentions.dart';

// class CustomButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String label;
//   final double? width;
//   final double? height;
//   final Color? color;
//   final TextStyle? labelStyle;
//   final bool? showLoading;
//   final EdgeInsets? buttonPadding;

//   const CustomButton({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.width,
//     this.height,
//     this.color,
//     this.labelStyle,
//     this.buttonPadding,
//     this.showLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: buttonPadding ?? AppPadding.customButtonPadding,
//       child: SizedBox(
//         height: height ?? 45,
//         width: width ?? MediaQuery.of(context).size.width,
//         child: ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor:
//                 color != null
//                     ? WidgetStateProperty.all(color)
//                     : WidgetStateProperty.all(AppColor.appThemeColor),
//             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//             ),
//           ),
//           onPressed: onPressed,
//           child:
//               showLoading == true
//                   ? const Center(
//                     child: CircularProgressIndicator(
//                       color: AppColor.whiteColor,
//                     ),
//                   )
//                   : Text(
//                     label,
//                     style:
//                         labelStyle ??
//                         context
//                             .textStyle(palette: ColorPalete.slate, swatch: 700)
//                             .large
//                             .semiBold,
//                   ),
//         ),
//       ),
//     );
//   }
// }

// class CustomTextButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String label;
//   final double? width;
//   final double? height;
//   final TextStyle? labelStyle;
//   final bool? showLoading;
//   final EdgeInsets? buttonPadding;

//   const CustomTextButton({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.width,
//     this.height,
//     this.labelStyle,
//     this.buttonPadding,
//     this.showLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: ButtonStyle(
//         padding: WidgetStateProperty.all<EdgeInsets>(
//           const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
//         ),
//         minimumSize: WidgetStateProperty.all(Size.zero),
//         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       ),
//       onPressed: onPressed ?? () => Navigator.pop(context),
//       child: Text(
//         label,
//         style:
//             labelStyle ??
//             context.textStyle(palette: ColorPalete.brand).large.semiBold,
//       ),
//     );
//   }
// }

// class CustomButtonWidthBoxShadow extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String label;
//   final Color? color;
//   final TextStyle? labelStyle;
//   final bool? showLoading;

//   const CustomButtonWidthBoxShadow({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.color,
//     this.labelStyle,
//     this.showLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     TextStyle labelTextStyle =
//         labelStyle ??
//         context.textStyle(palette: ColorPalete.white).medium.semiBold;
//     Color buttonColor =
//         color ?? context.applyAppColor(palette: ColorPalete.brand);
//     return GestureDetector(
//       onTap: onPressed ?? () {},
//       child: Container(
//         height: 45,
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: const [
//             BoxShadow(
//               color: Color.fromARGB(255, 227, 227, 227),
//               spreadRadius: 2,
//               blurRadius: 2,
//               offset: Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Center(child: Text(label, style: labelTextStyle)),
//       ),
//     );
//   }
// }

// class CustomDialogButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String label;

//   final bool isDestructiveAction;

//   const CustomDialogButton({
//     super.key,
//     required this.label,
//     this.isDestructiveAction = false,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isIOS) {
//       return CupertinoDialogAction(
//         isDefaultAction: true,
//         isDestructiveAction: isDestructiveAction,
//         onPressed: onPressed ?? () => Navigator.pop(context, false),
//         child: Text(label),
//       );
//     } else {
//       return TextButton(
//         onPressed: onPressed ?? () => Navigator.pop(context, false),
//         child: Text(
//           label,
//           style: TextStyle(
//             color:
//                 isDestructiveAction
//                     ? AppColor.redColor
//                     : AppColor.appThemeColor,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       );
//     }
//   }
// }

// class CustomButtonWithIcon extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String label;
//   final double? width;
//   final Color? color;
//   final Color? labelColor;
//   final bool? showLoading;

//   const CustomButtonWithIcon({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.width,
//     this.color,
//     this.labelColor,
//     this.showLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 48,
//       width: width ?? MediaQuery.of(context).size.width,
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor:
//               color != null
//                   ? WidgetStateProperty.all(color)
//                   : WidgetStateProperty.all(
//                     context.applyAppColor(
//                       palette: ColorPalete.brand,
//                       swatch: 500,
//                     ),
//                   ),
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           ),
//         ),
//         onPressed: onPressed,
//         child:
//             showLoading == true
//                 ? const Center(
//                   child: CircularProgressIndicator(color: AppColor.whiteColor),
//                 )
//                 : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       label,
//                       style:
//                           context
//                               .textStyle(
//                                 palette: ColorPalete.white,
//                                 swatch: 500,
//                               )
//                               .large
//                               .semiBold,
//                     ),
//                     SizedBox(width: 10.w),
//                     Iconoir.ArrowRight(
//                       width: 20.w,
//                       height: 20.h,
//                       color: context.applyAppColor(palette: ColorPalete.white),
//                     ),
//                   ],
//                 ),
//       ),
//     );
//   }
// }

// class CustomOutlinedButtonWithIcon extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String label;
//   final double? width;
//   final Color? borderColor;
//   final bool? showLoading;
//   final Widget? icon;
//   final bool isIconLeft;
//   final TextStyle? labelStyle;

//   const CustomOutlinedButtonWithIcon({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.width,
//     this.borderColor,
//     this.labelStyle,
//     this.showLoading = false,
//     this.icon,
//     this.isIconLeft = false, // Default: Icon on the right
//   });

//   @override
//   Widget build(BuildContext context) {
//     TextStyle labelTextStyle =
//         labelStyle ??
//         context
//             .textStyle(palette: ColorPalete.brand, swatch: 500)
//             .large
//             .semiBold;
//     return SizedBox(
//       height: 48.h,
//       width: width ?? MediaQuery.of(context).size.width,
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(
//             color:
//                 borderColor ??
//                 context.applyAppColor(palette: ColorPalete.brand, swatch: 500),
//             width: 2,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         onPressed: onPressed,
//         child:
//             showLoading == true
//                 ? const Center(child: CircularProgressIndicator())
//                 : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (isIconLeft && icon != null) icon!,
//                     if (isIconLeft && icon != null) SizedBox(width: 10.w),
//                     Text(label, style: labelTextStyle),
//                     if (!isIconLeft && icon != null) SizedBox(width: 10.w),
//                     if (!isIconLeft && icon != null) icon!,
//                   ],
//                 ),
//       ),
//     );
//   }
// }

// class CustomBorderButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String label;
//   final double? width;
//   final Color? borderColor;
//   final TextStyle? labelStyle;
//   final Color? labelColor;
//   final bool? showLoading;
//   final Widget? icon;
//   final bool isIconLeft; // Controls icon position

//   const CustomBorderButton({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.width,
//     this.borderColor,
//     this.labelColor,
//     this.showLoading = false,
//     this.icon,
//     this.isIconLeft = false,
//     this.labelStyle, // Default: Icon on the right
//   });

//   @override
//   Widget build(BuildContext context) {
//     TextStyle labelTextStyle =
//         labelStyle ??
//         context.textStyle(palette: ColorPalete.brand).medium.semiBold;
//     return SizedBox(
//       height: 45,
//       width: width ?? MediaQuery.of(context).size.width,
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(
//             color:
//                 borderColor ??
//                 context.applyAppColor(palette: ColorPalete.brand, swatch: 500),
//             width: 2,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         onPressed: onPressed ?? () {},
//         child:
//             showLoading == true
//                 ? const Center(child: CircularProgressIndicator())
//                 : Text(label, style: labelTextStyle),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_padding.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  final Color? color;
  final TextStyle? labelStyle;
  final bool? showLoading;
  final EdgeInsets? buttonPadding;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.color,
    this.labelStyle,
    this.buttonPadding,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding ?? AppPadding.customButtonPadding,
      child: SizedBox(
        height: height ?? 40,
        width: width ?? MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                color != null
                    ? WidgetStateProperty.all(color)
                    : WidgetStateProperty.all(AppColor.appThemeColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          onPressed: onPressed,
          child:
              showLoading == true
                  ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.whiteColor,
                    ),
                  )
                  : Text(
                    label,
                    style:
                        labelStyle ??
                        context
                            .textStyle(palette: ColorPalete.slate, swatch: 700)
                            .large
                            .semiBold,
                  ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;
  final bool? showLoading;
  final EdgeInsets? buttonPadding;

  const CustomTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.labelStyle,
    this.buttonPadding,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
        ),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
      child: Text(
        label,
        style:
            labelStyle ??
            context.textStyle(palette: ColorPalete.brand).large.semiBold,
      ),
    );
  }
}

class CustomButtonWidthBoxShadow extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? color;
  final TextStyle? labelStyle;
  final bool? showLoading;

  const CustomButtonWidthBoxShadow({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
    this.labelStyle,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle =
        labelStyle ??
        context.textStyle(palette: ColorPalete.white).medium.semiBold;
    Color buttonColor =
        color ?? context.applyAppColor(palette: ColorPalete.brand);
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 227, 227, 227),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(child: Text(label, style: labelTextStyle)),
      ),
    );
  }
}

class CustomDialogButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  final bool isDestructiveAction;

  const CustomDialogButton({
    super.key,
    required this.label,
    this.isDestructiveAction = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoDialogAction(
        isDefaultAction: true,
        isDestructiveAction: isDestructiveAction,
        onPressed: onPressed ?? () => Navigator.pop(context, false),
        child: Text(label),
      );
    } else {
      return TextButton(
        onPressed: onPressed ?? () => Navigator.pop(context, false),
        child: Text(
          label,
          style: TextStyle(
            color:
                isDestructiveAction
                    ? AppColor.redColor
                    : AppColor.appThemeColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
  }
}

class CustomButtonWithoutIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final Color? color;
  final Color? labelColor;
  final bool? showLoading;

  const CustomButtonWithoutIcon({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.color,
    this.labelColor,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              color != null
                  ? WidgetStateProperty.all(color)
                  : WidgetStateProperty.all(
                    context.applyAppColor(
                      palette: ColorPalete.brand,
                      swatch: 500,
                    ),
                  ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        onPressed: onPressed,
        child:
            showLoading == true
                ? const Center(
                  child: CircularProgressIndicator(color: AppColor.whiteColor),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.white,
                                swatch: 500,
                              )
                              .largeBody
                              .semiBold,
                    ),
                    // SizedBox(width: 10.w),
                    // Iconoir.ArrowRight(
                    //   width: 20.w,
                    //   height: 20.h,
                    //   color: context.applyAppColor(palette: ColorPalete.white),
                    // ),
                  ],
                ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final Color? color;
  final Color? labelColor;
  final bool? showLoading;

  const CustomButtonWithIcon({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.color,
    this.labelColor,
    this.showLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              color != null
                  ? WidgetStateProperty.all(color)
                  : WidgetStateProperty.all(
                    context.applyAppColor(
                      palette: ColorPalete.brand,
                      swatch: 500,
                    ),
                  ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        onPressed: onPressed,
        child:
            showLoading == true
                ? const Center(
                  child: CircularProgressIndicator(color: AppColor.whiteColor),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style:
                          context
                              .textStyle(
                                palette: ColorPalete.white,
                                swatch: 500,
                              )
                              .largeBody
                              .semiBold,
                    ),
                    SizedBox(width: 10.w),
                    iconoir.ArrowRight(
                      width: 20.w,
                      height: 20.h,
                      color: context.applyAppColor(palette: ColorPalete.white),
                    ),
                  ],
                ),
      ),
    );
  }
}

class CustomOutlinedButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final Color? borderColor;
  final bool? showLoading;
  final Widget? icon;
  final bool isIconLeft;
  final TextStyle? labelStyle;

  const CustomOutlinedButtonWithIcon({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.borderColor,
    this.labelStyle,
    this.showLoading = false,
    this.icon,
    this.isIconLeft = false, // Default: Icon on the right
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle =
        labelStyle ??
        context
            .textStyle(palette: ColorPalete.brand, swatch: 500)
            .large
            .semiBold;
    return SizedBox(
      height: 48.h,
      width: width ?? MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                borderColor ??
                context.applyAppColor(palette: ColorPalete.brand, swatch: 500),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
        child:
            showLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isIconLeft && icon != null) icon!,
                    if (isIconLeft && icon != null) SizedBox(width: 10.w),
                    Text(label, style: labelTextStyle),
                    if (!isIconLeft && icon != null) SizedBox(width: 10.w),
                    if (!isIconLeft && icon != null) icon!,
                  ],
                ),
      ),
    );
  }
}

class CustomBorderButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final Color? borderColor;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final bool? showLoading;
  final Widget? icon;
  final bool isIconLeft; // Controls icon position

  const CustomBorderButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.borderColor,
    this.labelColor,
    this.showLoading = false,
    this.icon,
    this.isIconLeft = false,
    this.labelStyle, // Default: Icon on the right
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle =
        labelStyle ??
        context.textStyle(palette: ColorPalete.brand).medium.semiBold;
    return SizedBox(
      height: 45,
      width: width ?? MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                borderColor ??
                context.applyAppColor(palette: ColorPalete.brand, swatch: 500),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed ?? () {},
        child:
            showLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Text(label, style: labelTextStyle),
      ),
    );
  }
}

class MyCustomTextButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const MyCustomTextButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0, // flat look
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r), // pill shape
          ),
          minimumSize: Size(double.infinity, 36.h), // height 36
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Satoshi",
            color: textColor,
          ),
        ),
      ),
    );
  }
}
