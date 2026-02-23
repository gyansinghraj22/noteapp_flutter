import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/features/login/widgets/background_with_image_widget.dart';
import 'package:noteapp/features/sign_up/bloc/signup_bloc.dart';

class DoctorDetailsInputScreen extends StatefulWidget {
  const DoctorDetailsInputScreen({super.key, required formData});

  @override
  State<DoctorDetailsInputScreen> createState() =>
      _DoctorDetailsInputScreenState();
}

class _DoctorDetailsInputScreenState extends State<DoctorDetailsInputScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  final _vetFormKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  List<CustomFormFieldConfig> formFields = [];
  bool canPop = false;
  bool isVetSelected = true;

  @override
  void initState() {
    getFormField();
    super.initState();
  }

  getFormField() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "clinic_name",
        label: "Enter Clinic's Name",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.dropDown,
        id: "professional_title",
        label: "Professional Title",
        options: [
          {"label": "DVM", "value": "DVM"},
          {"label": "BVSc", "value": "BVSc"},
          {"label": "MVSc", "value": "MVSc"},
          {"label": "PhD", "value": "PhD"},
        ],
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.datepicker,
        id: "issued_by",
        label: "Issued BY",
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "Enter License Number",
        label: "Veterinary License Number",
        isRequired: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: buildSilverAppBar(),
        ),
      ),
    );
  }

  Container buildSignUpFormField(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,

      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 28,
          left: 28,
          right: 28,
          bottom: 28,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Text(
              "Fill up the basic requirements",
              textAlign: TextAlign.center,
              style: context.textBlackStyle().bold.header4,
            ),
            const SizedBox(height: 8),

            CustomFormFieldGenerator(
              formKey: _vetFormKey,
              onFieldSubmitted: (data) {
                formData = data;
                setState(() {});
              },
              formFields: formFields,
            ),
            CustomButton(
              height: 55,
              onPressed: () {
                final Map<String, dynamic> request = {
                  "email": formData['email'],
                  "password": formData['password'],
                  "full_name": formData['full_name'],
                  "user_type": isVetSelected ? "doctor" : "user",
                  "clinic_name": formData['clinic_name'],
                  "professional_title": formData['professional_title'],
                  "issued_by": formData['issued_by'],
                  "license_number": formData['license_number'],
                };

                _loadingOverlay.show(context);
                BlocProvider.of<SignupBloc>(
                  context,
                ).add(SignupWithPassword(formData: request));
              },

              color: context.applyAppColor(palette: ColorPalete.brand),
              labelStyle:
                  context.textStyle(palette: ColorPalete.white).xlarge.semiBold,
              buttonPadding: EdgeInsets.zero,

              label: "Sign Up As a Doctor",
            ),
          ],
        ),
      ),
    );
  }

  CustomScrollView buildSilverAppBar() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: AppColor.spalshScreenBGColor,
          automaticallyImplyLeading: false,
          pinned: true,
          snap: true,
          floating: true,
          // expandedHeight: 200.h,
          flexibleSpace: const FlexibleSpaceBar(
            background: Hero(
              tag: "toolbar",
              child: BackgroundWithImageWidget(),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 1, (
            BuildContext context,
            int index,
          ) {
            return buildSignUpFormField(context);
          }),
        ),
      ],
    );
  }
}
