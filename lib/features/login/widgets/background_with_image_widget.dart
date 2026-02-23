import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/app_images.dart';

class BackgroundWithImageWidget extends StatelessWidget {
  const BackgroundWithImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.only(left: 36.w, right: 36.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.tearDrop, width: 53.w, height: 48.h),

            // Image.asset(AppImages.appImage, height: 35.h, width: 41.w),
            // Image.asset(
            //   AppImages.onlineConnectionImage,
            //   height: 200.h,
            //   width: 200.w,
            // ),
          ],
        ),
      ),
    );
  }
}
