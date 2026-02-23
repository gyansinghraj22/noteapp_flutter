import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:jp_prefecture/jp_prefecture.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/common/show_dialog/show_dialog.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_helpers.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/features/profile/bloc/profile_bloc.dart';
import 'package:noteapp/features/sign_up/widgets/upload_image_widget.dart';

class EnterProfileInfoScreen extends StatefulWidget {
  final Map<dynamic, dynamic> userInfo;
  const EnterProfileInfoScreen({super.key, required this.userInfo});

  @override
  State<EnterProfileInfoScreen> createState() => _EnterProfileInfoScreenState();
}

class _EnterProfileInfoScreenState extends State<EnterProfileInfoScreen> {
  String profileImage = '';
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _professionalDetailsFormKey = GlobalKey<FormState>();
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  Map<String, dynamic> basicInfoData = {};
  Map<String, dynamic> professionalData = {};
  List<CustomFormFieldConfig> basicInfo = [];
  List<CustomFormFieldConfig> professionalDetails = [];
  @override
  void initState() {
    getFormField();
    super.initState();
  }

  getFormField() {
    final prefs = JpPrefecture.all;
    List<Map<String, String>> prefectureList = [];
    for (var element in prefs) {
      prefectureList.add({
        "label": element.name,
        "value": element.name.toString(),
      });
    }
    basicInfo = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "fullName",
        label: "Full Name",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "gender",
        label: "Gender",
        options: [
          {"label": "Male", "value": "male"},
          {"label": "Female", "value": "female"},
          {"label": "Other", "value": "other"},
        ],
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.phone,
        id: "contactNumber",
        label: "Contact Number",
        isRequired: true,
      ),
    ];

    professionalDetails = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "company",
        label: "MLM Company Name or Affiliation",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "role",
        label: "Role",
        options: [
          {"label": "User", "value": "user"},
          {"label": "Admin", "value": "Admin"},
        ],
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "region",
        label: "Primary Region",
        options: prefectureList,
        isRequired: true,
      ),
    ];
  }

  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          _loadingOverlay.hide();
          RouteHelpers.pushRemoveRoute(context, RoutePaths.homeScreen);
        } else if (state is UpdateProfileErrorState) {
          _loadingOverlay.hide();
          ShowDialog(
            context: context,
          ).showErrorStateDialog(body: state.errorModel.message.toString());
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Iconoir.ArrowLeft(
                        width: 24,
                        height: 24,
                        color: context.applyAppColor(
                          palette: ColorPalete.brand,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Edit Profile Info",
                            style:
                                context
                                    .textStyle(palette: ColorPalete.brand)
                                    .header3,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Basic Information",
                              style:
                                  context
                                      .textStyle(palette: ColorPalete.neutral)
                                      .medium
                                      .regular,
                            ),
                          ),
                          const SizedBox(height: 16),
                          UploadPhotoWidget(
                            onSuccess: (imageUrl) {
                              basicInfoData['profilePicture'] = imageUrl;
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 12),
                          CustomFormFieldGenerator(
                            onFieldSubmitted: (data) {
                              basicInfoData = data;
                              setState(() {});
                            },
                            updateData: widget.userInfo,
                            formKey: _basicInfoFormKey,
                            formFields: basicInfo,
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Professional Details",
                              style:
                                  context
                                      .textStyle(palette: ColorPalete.neutral)
                                      .medium
                                      .regular,
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomFormFieldGenerator(
                            formFields: professionalDetails,
                            onFieldSubmitted: (data) {
                              professionalData = data;
                              setState(() {});
                            },
                            updateData: widget.userInfo,
                            formKey: _professionalDetailsFormKey,
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            onPressed: () {
                              if (_basicInfoFormKey.currentState!.validate() &&
                                  _professionalDetailsFormKey.currentState!
                                      .validate()) {
                                _basicInfoFormKey.currentState!.save();
                                _professionalDetailsFormKey.currentState!
                                    .save();
                                Map<String, dynamic> formData = {
                                  ...basicInfoData,
                                  ...professionalData,
                                };

                                _loadingOverlay.show(context);
                                BlocProvider.of<ProfileBloc>(context).add(
                                  UpdateProfileInfoEvent(formData: formData),
                                );
                              }
                            },
                            height: 55,
                            labelStyle:
                                context
                                    .textStyle(palette: ColorPalete.white)
                                    .xlarge
                                    .semiBold,
                            color: context.applyAppColor(
                              palette: ColorPalete.brand,
                            ),
                            buttonPadding: EdgeInsets.zero,
                            label: "Edit",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
