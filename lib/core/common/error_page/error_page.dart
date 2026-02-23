import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onClose;

  const ErrorPage({super.key, this.title, this.message, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          // height: 358.h,
          // width: 341.w,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 48.w),
          padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error icon with circular background
              Container(
                width: 131.w,
                height: 131.h,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(
                  Icons.block,
                  size: 96.sp,
                  color: const Color(0xFFDE1515),
                ),
              ),
              SizedBox(height: 32.h),

              // Text section
              Column(
                children: [
                  Text(
                    title ?? 'Feature not available',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0A3128),
                      fontFamily: "Satoshi",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 252.w,
                    child: Text(
                      message ?? 'You can\'t perform this action right now',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF737373),
                        fontFamily: "Satoshi",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Close button
              GestureDetector(
                onTap: onClose ?? () => Navigator.pop(context),
                child: Container(
                  width: 245.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1DC7F2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFAFAFA),
                      fontFamily: "Satoshi",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ErrorPage extends StatefulWidget {
//   const ErrorPage({super.key});

//   @override
//   State<ErrorPage> createState() => _ErrorPageState();
// }

// class _ErrorPageState extends State<ErrorPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BasePage(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ImageWidget.showLocalImage(
//               AppImages.errorImage,
//               height: 300,
//               width: 200,
//             ),
//             const Text("Page Not Found",),
//             const SizedBox(height: 20),
//             CustomButton(
//               color: AppColor.greyColor,
//               width: MediaQuery.of(context).size.width / 2,
//               label: "Go Back",
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
