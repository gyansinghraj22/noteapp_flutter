import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as Iconoir;
import 'package:noteapp/constants/app_colors.dart';
import 'package:noteapp/constants/key_string.dart';
import 'package:noteapp/core/common/custom_button/custom_button.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_config.dart';
import 'package:noteapp/core/common/custom_form_field/custom_form_field_generator.dart';
import 'package:noteapp/core/common/loading_overlay/loading_overlay.dart';
import 'package:noteapp/core/common/show_dialog/show_dialog.dart';
import 'package:noteapp/core/common/snackbar/snackbar.dart';
import 'package:noteapp/core/extention/color_extention.dart';
import 'package:noteapp/features/login/bloc/login_bloc.dart';
import 'package:noteapp/features/login/widgets/background_with_image_widget.dart';
import 'package:noteapp/features/login/widgets/login_footer_view.dart';
import 'package:noteapp/features/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:noteapp/core/routes/route_helpers.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/core/typography/font_style_extentions.dart';
import 'package:noteapp/core/utils/shared_pref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  Map<String, dynamic> formData = {};
  final _formKey = GlobalKey<FormState>();
  bool isRemember = false;
  String savedEmail = '';
  List<CustomFormFieldConfig> formFields = [];
  bool canPop = false;

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  getInitialData() {
    isRemember = SharedPref.getBoolValue(KeyString.loginRemember.name);

    if (isRemember) {
      savedEmail = SharedPref.getStringValue(KeyString.userEmail.name);
    }

    formFields = [
      const CustomFormFieldConfig(
        fieldType: FieldType.email,
        id: "username",
        label: "Email Address",
        isRequired: true,
      ),
      const CustomFormFieldConfig(
        fieldType: FieldType.confirmPassword,
        id: "password",
        label: "Password",
        isRequired: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          _loadingOverlay.hide();
          RouteHelpers.pushRemoveRoute(context, RoutePaths.homeScreen);
        } else if (state is UserLoginErrorState) {
          _loadingOverlay.hide();
          ShowDialog(context: context).showErrorStateDialog(
            body: state.errorModel.message.toString(),
            onTab:
                state.errorModel.code == 403
                    ? () {
                      BlocProvider.of<OtpVerificationBloc>(
                        context,
                      ).add(SendOtpEvent(email: formData['username']));
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        RoutePaths.oTPVerificationScreen,
                        arguments: {"email": formData['username']},
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
              padding: EdgeInsets.only(top: 25.h),
              child: buildSilverAppBar(),
            ),
          ),
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
          // expandedHeight: 200.h,
          flexibleSpace: const FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Hero(
              tag: "toolbar",
              child: BackgroundWithImageWidget(),
            ),
          ),
        ),
        // SliverFixedExtentList(
        //   itemExtent: 1,
        //   delegate: SliverChildBuilderDelegate(
        //     (BuildContext context, int index) {
        //       return buildLoginFormField();
        //     },
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 1, (
            BuildContext context,
            int index,
          ) {
            return buildLoginFormField();
          }),
        ),
      ],
    );
  }

  Container buildLoginFormField() {
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
        padding: const EdgeInsets.only(top: 28, left: 28, right: 28),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              "Focus on your thoughts",
              textAlign: TextAlign.center,
              style:
                  context
                      .textStyle(palette: ColorPalete.zinc, swatch: 900)
                      .header3,
            ),
            const SizedBox(height: 8),
            Text(
              "Capture ideas instantly, organize effortlessly",
              textAlign: TextAlign.center,
              style: context.textBlackStyle().large.bold.copyWith(color: AppColor.greyColor),
            ),
            SizedBox(height: 24.h),
            CustomFormFieldGenerator(
              onFieldSubmitted: (data) {
                formData = data;
                setState(() {});
              },
              formKey: _formKey,
              updateData: {'username': savedEmail},
              formFields: formFields,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    isRemember = !isRemember;
                    SharedPref.setBoolValue(
                      KeyString.loginRemember.name,
                      isRemember,
                    );
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      isRemember
                          ? Iconoir.CheckSquare(
                            width: 20,
                            height: 20,
                            color: context.applyAppColor(
                              palette: ColorPalete.green,
                            ),
                          )
                          : Icon(
                            Icons.square_outlined,
                            size: 20,
                            color: context.applyAppColor(
                              palette: ColorPalete.slate,
                            ),
                          ),
                      const SizedBox(width: 5),
                      Text(
                        "Remember Me",
                        style:
                            context
                                .textStyle(
                                  palette: ColorPalete.neutral,
                                  swatch: 800,
                                )
                                .xsmall
                                .regular,
                      ),
                    ],
                  ),
                ),
                TextButton(
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
                    Navigator.pushNamed(
                      context,
                      RoutePaths.resetPasswordEmailScreen,
                    );
                  },
                  child: Text(
                    " Forgot Password?",
                    style: context
                        .textStyle(palette: ColorPalete.brand, swatch: 500)
                        .small
                        .regular
                        .copyWith(decorationThickness: 1.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              height: 50,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // _loadingOverlay.show(context);
                  Navigator.pushNamed(context, "/homeScreen");

                  // BlocProvider.of<LoginBloc>(
                  //   context,
                  // ).add(UserLoginEvent(formData: formData));
                }
              },
              labelStyle:
                  context.textStyle(palette: ColorPalete.white).xlarge.semiBold,
              color: context.applyAppColor(
                palette: ColorPalete.brand,
                swatch: 300,
              ),
              buttonPadding: EdgeInsets.zero,
              label: "Log In",
            ),
            const SizedBox(height: 16),
            const AuthenticateFooterView(routePath: 'loginScreen'),
          ],
        ),
      ),
    );
  }
}
