import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/common/show_dialog/show_dialog.dart';
import 'package:noteapp/core/common/snackbar/snackbar.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/features/login/widgets/background_with_image_widget.dart';
import 'package:noteapp/features/login/widgets/login_footer_view.dart';
import 'package:noteapp/features/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:noteapp/features/sign_up/bloc/signup_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  List<CustomFormFieldConfig> formFields = [];
  bool canPop = false;
  String password = '';
  String confirmPassword = '';
  // bool isVetSelected = true;

  @override
  void initState() {
    getFormField();
    super.initState();
  }

  getFormField() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.text,
        id: "name",
        label: "Full Name",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.email,
        id: "email",
        label: "Email Address",
        isRequired: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.password,
        id: "password",
        label: "Password",
        isRequired: true,
        onChanged: (String value) {
          password = value;
          setState(() {});
        },
        isObscure: true,
      ),
      CustomFormFieldConfig(
        fieldType: FieldType.confirmPassword,
        id: "confirmPassword",
        label: "Confirm Password",
        isObscure: true,
        onChanged: (String value) {
          confirmPassword = value;
          setState(() {});
        },
        isRequired: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupWithPasswordSuccessState) {
          _loadingOverlay.hide();
          Navigator.pushNamed(
            context,
            RoutePaths.oTPVerificationScreen,
            arguments: {"email": formData['email']},
          );
        } else if (state is SignupWithPasswordErrorState) {
          _loadingOverlay.hide();
          ShowDialog(context: context).showErrorStateDialog(
            body: state.errorModel.message.toString(),
            onTab:
                state.errorModel.code == 403
                    ? () {
                      BlocProvider.of<OtpVerificationBloc>(
                        context,
                      ).add(SendOtpEvent(email: formData['email']));
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        RoutePaths.oTPVerificationScreen,
                        arguments: {"email": formData['email']},
                      );
                    }
                    : null,
          );
        }
      },
      child: PopScope(
        canPop: canPop,
        onPopInvokedWithResult: (bool value, dynamic val) {
          setState(() {
            canPop = !value;
          });

          if (canPop) {
            showAppExistSnackBar(context);
          }
        },
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: buildSilverAppBar(),
            ),
          ),
        ),
      ),
    );
  }

  Container buildLoginFormField(BuildContext context) {
    return Container(
      width: double.infinity,
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
          children: [
            Text(
              "Create Your Account",
              textAlign: TextAlign.center,
              style: context.textBlackStyle().bold.header4,
            ),
            const SizedBox(height: 8),
            Text(
              "Sign up to access all features",
              textAlign: TextAlign.center,
              style: context.textBlackStyle().medium.bold,
            ),
            const SizedBox(height: 18),

            // SizedBox(
            //   width: 20.w,
            //   child: VetUserSwitch(
            //     initialIsVet: true,
            //     onChanged: (isVet) {
            //       setState(() {
            //         isVetSelected = isVet;
            //       });
            //     },
            //   ),
            // ),
            CustomFormFieldGenerator(
              formKey: _formKey,
              onFieldSubmitted: (data) {
                formData = data;
                setState(() {});
              },
              formFields: formFields,
            ),
            Visibility(
              visible:
                  (password.isNotEmpty &&
                      confirmPassword.isNotEmpty &&
                      password != confirmPassword),
              child: Text(
                "Password and Confirm Password must be the same.",
                style:
                    context.textStyle(palette: ColorPalete.red).xsmall.regular,
              ),
            ),
            const SizedBox(height: 5),
            CustomButton(
              height: 55,
              onPressed: () {
                final bool isPasswordValid =
                    password.isNotEmpty &&
                    confirmPassword.isNotEmpty &&
                    password == confirmPassword;

                if (!_formKey.currentState!.validate() || !isPasswordValid) {
                  return;
                }

                final Map<String, dynamic> request = {
                  "email": formData['email'],
                  "password": password,
                };
                print(request);

                // _loadingOverlay.show(context);
                // BlocProvider.of<SignupBloc>(
                //   context,
                // ).add(SignupWithPassword(formData: request));
                Navigator.pushNamed(
                  context,
                  RoutePaths.oTPVerificationScreen,
                  arguments: {"email": formData['email']},
                );
              },

              color: context.applyAppColor(palette: ColorPalete.brand),
              labelStyle:
                  context.textStyle(palette: ColorPalete.white).xlarge.semiBold,
              buttonPadding: EdgeInsets.zero,

              label: "Sign Up",
            ),
            const SizedBox(height: 16),
            const AuthenticateFooterView(routePath: ""),
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
            return buildLoginFormField(context);
          }),
        ),
      ],
    );
  }
}
