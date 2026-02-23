import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class LoadingOverlay {
  OverlayEntry? _overlay;

  LoadingOverlay();

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder:
            (context) => const PopScope(
              canPop: false,
              child: ColoredBox(
                color: Color(0x80000000),
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          AppColor.appThemeColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  void showLoaderWithMessage(BuildContext context, {required String message}) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder:
            (context) => PopScope(
              canPop: false,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ColoredBox(
                  color: const Color(0x80000000),
                  child: Center(
                    child: Card(
                      color: AppColor.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              message.toString(),
                              style:
                                  context
                                      .textStyle(palette: ColorPalete.brand)
                                      .medium
                                      .semiBold,
                            ),
                            const SizedBox(width: 10),
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColor.appThemeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}
