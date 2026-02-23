import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/constants/api_urls.dart';
import 'package:noteapp/core/config/themes.dart';
import 'package:noteapp/core/di/injector.dart';
import 'package:noteapp/core/language/cubit/language_cubit.dart';
import 'package:noteapp/core/language/l10n.dart';
import 'package:noteapp/core/localization/get_localization_string.dart';
import 'package:noteapp/core/navigation_service/navigation_service.dart';
import 'package:noteapp/core/routes/route_handler.dart';
import 'package:noteapp/core/splash/splash_screen.dart';
import 'package:noteapp/core/utils/shared_pref.dart';
import 'package:noteapp/features/login/bloc/login_bloc.dart';
import 'package:noteapp/features/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:noteapp/features/otp_verification/cubit/resend_timer_cubit.dart';
import 'package:noteapp/features/profile/bloc/profile_bloc.dart';
import 'package:noteapp/features/reset_password/bloc/reset_password_bloc.dart';
import 'package:noteapp/features/sign_up/bloc/signup_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ChuckerFlutter.showNotification = true;
  await SharedPref.initializeSharedPreference();
  await setUpDi(ApiUrls.devBaseUrl);
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) => LanguageCubit(),
        ),

        BlocProvider<SignupBloc>(
          create: (BuildContext context) => SignupBloc(),
        ),

        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),

        BlocProvider<ResetPasswordBloc>(
          create: (BuildContext context) => ResetPasswordBloc(),
        ),
        BlocProvider<ResendTimerCubit>(
          create: (BuildContext context) => ResendTimerCubit(),
        ),
        BlocProvider<OtpVerificationBloc>(
          create: (BuildContext context) => OtpVerificationBloc(),
        ),

        // BlocProvider<ExportFileBloc>(
        //   create: (BuildContext context) => ExportFileBloc(),
        // ),
        // BlocProvider<UploadFileBloc>(
        //   create: (BuildContext context) => UploadFileBloc(),
        // ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                // builder: DevicePreview.appBuilder,
                navigatorObservers: [ChuckerFlutter.navigatorObserver],
                title: 'Vetyo',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: L10n.all,
                locale: state,
                theme: AppThemes.lightTheme,
                initialRoute: '/',
                onGenerateRoute: RouteHandler.generateRoute,
                navigatorKey: NavigationService.navigatorKey,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
