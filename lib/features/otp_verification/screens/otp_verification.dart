import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/custom_otp_input_form_field.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/common/show_dialog/show_dialog.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/features/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:noteapp/features/otp_verification/cubit/resend_timer_cubit.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  String otpNumber = '';
  Timer? resendTimer;

  @override
  void initState() {
    startResendTimer();
    super.initState();
  }

  void resendOTP(BuildContext context) async {
    _loadingOverlay.show(context);
    BlocProvider.of<OtpVerificationBloc>(
      context,
    ).add(SendOtpEvent(email: widget.email));

    resendTimer?.cancel();
    startResendTimer();
  }

  void startResendTimer() async {
    int counter = 0;
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter = counter + 1;
      if (counter < 62 && mounted) {
        BlocProvider.of<ResendTimerCubit>(context).getResendTime(counter);
      } else {
        resendTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccessState) {
          _loadingOverlay.hide();
          Navigator.pushNamed(
            context,
            RoutePaths.oTPVerifySuccessScreen,
            arguments: {"navigatorPath": RoutePaths.userInformationInputScreen},
          );
        } else if (state is OtpVerificationErrorState) {
          _loadingOverlay.hide();
          ShowDialog(
            context: context,
          ).showErrorStateDialog(body: state.errorModel.message.toString());
        } else if (state is SendOtpSuccessState) {
          _loadingOverlay.hide();
        } else if (state is SendOtpErrorState) {
          _loadingOverlay.hide();
          ShowDialog(
            context: context,
          ).showErrorStateDialog(body: state.errorModel.message.toString());
        }
      },
      child: BasePage(
        showAppBar: false,
        bodyColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Text(
                    "Create Account",
                    style:
                        context.textStyle(palette: ColorPalete.brand).header3,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Fill your information below",
                    style:
                        context
                            .textStyle(palette: ColorPalete.neutral)
                            .medium
                            .semiBold,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Verify Email",
                    style:
                        context.textStyle(palette: ColorPalete.brand).header4,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please enter the code we just sent to",
                    style:
                        context
                            .textStyle(palette: ColorPalete.neutral)
                            .medium
                            .regular,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.email,
                    style:
                        context
                            .textStyle(palette: ColorPalete.brand)
                            .medium
                            .regular,
                  ),
                  const SizedBox(height: 40),
                  CustomOtpInputFormField(
                    numberOfFields: 4,
                    fieldWidth: 70,
                    fieldHeight: 58,
                    autoFocus: false,
                    textStyle:
                        context
                            .textStyle(palette: ColorPalete.brand)
                            .medium
                            .semiBold,
                    focusedBorderColor: const Color.fromARGB(
                      255,
                      156,
                      128,
                      194,
                    ),
                    fillColor: const Color.fromARGB(255, 156, 128, 194),
                    borderColor: const Color.fromARGB(255, 156, 128, 194),
                    onChanged: (val) {},
                    onCompleted: (val) {
                      setState(() {
                        otpNumber = val;
                      });
                    },
                    otpController: otpController,
                    borderRadius: 2,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Didn’t Receive Code?",
                    style:
                        context
                            .textStyle(
                              palette: ColorPalete.neutral,
                              swatch: 800,
                            )
                            .xsmall
                            .regular,
                  ),
                  const SizedBox(height: 4),
                  BlocBuilder<ResendTimerCubit, ResendTimerState>(
                    builder: (context, state) {
                      if (state is ResendTimeLeftState) {
                        return TextButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                right: 8,
                                left: 8,
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all(Size.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            if (state.resend) {
                              resendOTP(context);
                            }
                          },
                          child: Text(
                            "Resend Code in ${state.resendTimeLeft}",
                            style: context
                                .textStyle(
                                  palette: ColorPalete.green,
                                  swatch: 600,
                                )
                                .xsmall
                                .regular
                                .copyWith(
                                  decorationThickness: 1.5,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        );
                      } else {
                        return Text(
                          "Resend Code in 60",
                          style: context
                              .textStyle(palette: ColorPalete.brand)
                              .xsmall
                              .regular
                              .copyWith(decoration: TextDecoration.underline),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onPressed: () {
                      _loadingOverlay.show(context);
                      BlocProvider.of<OtpVerificationBloc>(context).add(
                        OtpVerifyEvent(
                          otpNumber: otpNumber,
                          email: widget.email,
                        ),
                      );
                      // Navigator.pushNamed(
                      //     context, RoutePaths.oTPVerifySuccessScreen,
                      //     arguments: {
                      //       "navigatorPath":
                      //           RoutePaths.userInformationInputScreen
                      //     });
                    },
                    height: 55,
                    labelStyle:
                        context
                            .textStyle(palette: ColorPalete.white)
                            .xlarge
                            .semiBold,
                    color: context.applyAppColor(palette: ColorPalete.brand),
                    buttonPadding: const EdgeInsets.only(left: 28, right: 28),
                    label: "Verify Email",
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
