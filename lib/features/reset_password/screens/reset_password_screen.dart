import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/cuatom_form_field.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/common/show_dialog/show_dialog.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/features/reset_password/bloc/reset_password_bloc.dart';
import 'package:noteapp/features/reset_password/widgets/reset_password_alert_dialog.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String otpNumber;
  final String? email;
  const ResetPasswordScreen({super.key, required this.otpNumber, this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          _loadingOverlay.hide();
          Navigator.pushNamed(context, RoutePaths.resetPasswordSuccessScreen);
        } else if (state is ResetPasswordErrorState) {
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
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
                  ),
                  const SizedBox(height: 24),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 28,
                        right: 28,
                        top: 28,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              "New Password",
                              style:
                                  context
                                      .textStyle(palette: ColorPalete.brand)
                                      .header4,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Your new password must be different\nfrom your old password",
                              textAlign: TextAlign.center,
                              style:
                                  context
                                      .textStyle(palette: ColorPalete.neutral)
                                      .medium
                                      .regular,
                            ),
                            const SizedBox(height: 28),
                            CustomFormField(
                              config: CustomFormFieldConfig(
                                fieldType: FieldType.password,
                                id: "newPassword",
                                controller: newPasswordController,
                                label: "New Password",
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Must be 8 characters.",
                                textAlign: TextAlign.left,
                                style:
                                    context
                                        .textStyle(palette: ColorPalete.slate)
                                        .medium
                                        .regular,
                              ),
                            ),
                            const SizedBox(height: 28),
                            CustomFormField(
                              config: CustomFormFieldConfig(
                                fieldType: FieldType.password,
                                id: "confirmPassword",
                                controller: confirmPasswordController,
                                label: "Confirm Password",
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Both passwords must match",
                                textAlign: TextAlign.left,
                                style:
                                    context
                                        .textStyle(palette: ColorPalete.slate)
                                        .medium
                                        .regular,
                              ),
                            ),
                            const SizedBox(height: 40),
                            CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    newPasswordController.text ==
                                        confirmPasswordController.text) {
                                  _formKey.currentState!.save();
                                  Map<String, dynamic> formData = {
                                    'oneTimePass': widget.otpNumber,
                                    "newPassword": newPasswordController.text,
                                    'email': widget.email,
                                  };

                                  showConfirmationDialog(context, formData);
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
                              label: "Confirm",
                            ),
                          ],
                        ),
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
