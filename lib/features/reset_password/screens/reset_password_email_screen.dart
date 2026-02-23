import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/app_images.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/cuatom_form_field.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/common/show_dialog/show_dialog.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/features/otp_verification/bloc/otp_verification_bloc.dart';

class ResetPasswordEmailScreen extends StatefulWidget {
  const ResetPasswordEmailScreen({super.key});

  @override
  State<ResetPasswordEmailScreen> createState() =>
      _ResetPasswordEmailScreenState();
}

class _ResetPasswordEmailScreenState extends State<ResetPasswordEmailScreen> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        if (state is SendOtpSuccessState) {
          _loadingOverlay.hide();
          Navigator.pushNamed(
            context,
            RoutePaths.resetPasswordOTPScreen,
            arguments: {"email": emailController.text.trim()},
          );
        } else if (state is SendOtpErrorState) {
          _loadingOverlay.hide();
          ShowDialog(
            context: context,
          ).showErrorStateDialog(body: state.errorModel.message.toString());
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
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
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      right: 28,
                      top: 28,
                    ),
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRect(child: Image.asset(AppImages.tearDrop)),
                            Text(
                              "Forgot Password ?",
                              style:
                                  context
                                      .textStyle(palette: ColorPalete.brand)
                                      .header4,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Enter your Email, we will send you a verification code.",
                              style:
                                  context
                                      .textStyle(palette: ColorPalete.neutral)
                                      .medium
                                      .regular,
                            ),
                            const SizedBox(height: 40),
                            CustomFormField(
                              config: CustomFormFieldConfig(
                                fieldType: FieldType.email,
                                id: "email",
                                controller: emailController,
                                label: "Email",
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(height: 40),
                            CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _loadingOverlay.show(context);
                                  BlocProvider.of<OtpVerificationBloc>(
                                    context,
                                  ).add(
                                    SendOtpEvent(
                                      email: emailController.text.trim(),
                                    ),
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
