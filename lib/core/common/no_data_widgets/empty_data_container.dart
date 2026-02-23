import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class EmptyDataContainer extends StatelessWidget {
  final String? title;
  final String? discription;
  final String? image;
  const EmptyDataContainer({
    super.key,
    this.title,
    this.discription,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 370,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(height: 200, width: 200, image ?? AppImages.appImage),
              const SizedBox(height: 40),
              Text(title ?? "No Data", style: context.textBlackStyle().header6),
              const SizedBox(height: 20),
              Text(
                discription ?? "No Data Found",
                textAlign: TextAlign.center,
                style: context.textBlackStyle().large.regular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
