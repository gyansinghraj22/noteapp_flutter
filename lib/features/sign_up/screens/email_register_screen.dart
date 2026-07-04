import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/core/common/base_page/base_page.dart';
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
import 'package:noteapp/features/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:noteapp/features/sign_up/bloc/signup_bloc.dart';

class EmailRegisterScreen extends StatefulWidget {
  const EmailRegisterScreen({super.key});

  @override
  State<EmailRegisterScreen> createState() => _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends State<EmailRegisterScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  List<CustomFormFieldConfig> formFields = [];
  bool canPop = false;

  @override
  void initState() {
    getFormField();
    super.initState();
  }

  getFormField() {
    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.email,
        id: "email",
        label: "Email Address",
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
            RoutePaths.signupScreen,
            arguments: {"email": formData['email'], "fromEmailRegister": true},
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
        child: BasePage(
          showAppBar: false,
          showBackButton: false,
          bodyColor: Theme.of(context).scaffoldBackgroundColor,
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

  Container buildEmailFormField(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
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
            CustomFormFieldGenerator(
              formKey: _formKey,
              onFieldSubmitted: (data) {
                formData = data;
                setState(() {});
              },
              formFields: formFields,
            ),
            const SizedBox(height: 24),
            CustomButton(
              height: 55,
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                final Map<String, dynamic> request = {
                  "email": formData['email'],
                };
                print(request);

                _loadingOverlay.show(context);
                BlocProvider.of<SignupBloc>(
                  context,
                ).add(SignupWithPassword(formData: request));
              },
              color: context.applyAppColor(palette: ColorPalete.brand),
              labelStyle:
                  context.textStyle(palette: ColorPalete.white).xlarge.semiBold,
              buttonPadding: EdgeInsets.zero,
              label: "Continue",
            ),
            const SizedBox(height: 16),
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
            return buildEmailFormField(context);
          }),
        ),
      ],
    );
  }
}
