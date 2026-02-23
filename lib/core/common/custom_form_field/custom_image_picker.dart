import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_listview/custom_list_tile.dart';
import 'package:noteapp/core/helpers/bottom_dialogs.dart';
import 'package:noteapp/core/utils/image_utils.dart';

class CustomImagePickerFormField extends StatefulWidget {
  final CustomFormFieldConfig config;
  const CustomImagePickerFormField({super.key, required this.config});

  @override
  State<CustomImagePickerFormField> createState() =>
      _CustomImagePickerFormFieldState();
}

class _CustomImagePickerFormFieldState
    extends State<CustomImagePickerFormField> {
  double width = 100;
  double height = 100;
  dynamic imageFile;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.greyColor,
                width: 4.0,
                style: BorderStyle.solid,
              ),
            ),
            height: height,
            width: width,
            child: getImage(),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: InkWell(
            onTap: () {
              BottomDialog.showBottomDialog(
                context: context,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 1 / 6,
                  child: ListView(
                    children: [
                      Card(
                        child: CustomListTile(
                          onPress: () async {
                            await ImageUtils.customImagePicker().then(
                              (value) => {
                                if (value != "")
                                  {
                                    setState(() {
                                      imageFile = value;
                                      isLoading = true;
                                    }),
                                  }
                                else
                                  {
                                    setState(() {
                                      isLoading = false;
                                    }),
                                  },
                              },
                            );
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                          },
                          title: const Text("Select Photo"),
                          leading: const Icon(Icons.image),
                        ),
                      ),
                      Card(
                        child: CustomListTile(
                          onPress: () async {
                            await ImageUtils.customCameraPicker().then(
                              (value) => {
                                if (value != "")
                                  {
                                    setState(() {
                                      imageFile = value;
                                    }),
                                  }
                                else
                                  {
                                    setState(() {
                                      isLoading = false;
                                    }),
                                  },
                              },
                            );
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                          },
                          title: const Text("Take Photo"),
                          leading: const Icon(Icons.camera),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 15,
              child: Icon(Icons.edit, size: 14),
            ),
          ),
        ),
      ],
    );
  }

  getImage() {
    if (widget.config.isLogIn == false) {
      return isLoading
          ? const Center(child: CircularProgressIndicator())
          : imageFile == null && widget.config.initialValue == ""
          ? Center(child: Image.asset(AppImages.errorImage))
          : imageFile is File
          ? Image.file(imageFile, fit: BoxFit.cover)
          : imageFile is String
          ? Image.network(imageFile, fit: BoxFit.cover)
          : FadeInImage.assetNetwork(
            image: imageFile.toString(),
            fit: BoxFit.cover,
            placeholder: AppImages.errorImage,
            imageErrorBuilder:
                (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.grey),
          );
    } else {
      return imageFile == null && widget.config.initialValue == ""
          ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.upload_file, size: 50),
                const SizedBox(height: 5),
                Text(widget.config.label),
              ],
            ),
          )
          : imageFile == null && widget.config.initialValue != ""
          ? const Center(child: CircularProgressIndicator())
          : imageFile is File
          ? Image.file(imageFile, fit: BoxFit.cover)
          : FadeInImage.assetNetwork(
            image: imageFile.toString(),
            fit: BoxFit.cover,
            placeholder: AppImages.errorImage,
            imageErrorBuilder:
                (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.grey),
          );
    }
  }
}
