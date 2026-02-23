import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/core/utils/image_utils.dart';

class UploadPhotoWidget extends StatefulWidget {
  final Function(String)? onSuccess;
  const UploadPhotoWidget({super.key, this.onSuccess});

  @override
  State<UploadPhotoWidget> createState() => _UploadPhotoWidgetState();
}

class _UploadPhotoWidgetState extends State<UploadPhotoWidget> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.applyAppColor(
              palette: ColorPalete.neutral,
              swatch: 100,
            ),
          ),
          child:
              imageFile != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(imageFile!, fit: BoxFit.cover),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () async {
                        File image = await ImageUtils.customImagePicker();
                        setState(() {
                          imageFile = image;
                        });
                        String imageUrl =
                            await ImageUtils.uploadImagesToServers(
                              image: image,
                              apiUrl: ApiUrls.uploadProfilePicture,
                            );
                        widget.onSuccess?.call(imageUrl);
                      },
                      child: Iconoir.Camera(
                        width: 32,
                        height: 32,
                        color: context.applyAppColor(
                          palette: ColorPalete.brand,
                        ),
                      ),
                    ),
                  ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload your photo",
              style:
                  context
                      .textStyle(palette: ColorPalete.brand, swatch: 500)
                      .large
                      .semiBold,
            ),
            const SizedBox(height: 8),
            Text(
              "Profile picture should be in standard\njpeg and png format and less than\n2MB",
              style:
                  context
                      .textStyle(palette: ColorPalete.neutral, swatch: 500)
                      .small
                      .regular,
            ),
          ],
        ),
      ],
    );
  }
}
