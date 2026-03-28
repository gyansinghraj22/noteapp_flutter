import 'package:flutter/material.dart';
import 'package:noteapp/core/common/custom_listview/custom_search_listview.dart';
import 'package:noteapp/core/common/error_page/error_page.dart';
import 'package:noteapp/features/collaboration_sharing/screens/collaboration_sharing_screen.dart';
import 'package:noteapp/features/home/home_page.dart';
import 'package:noteapp/features/login/screens/login_screen.dart';
import 'package:noteapp/features/note/screens/add_note.dart';
import 'package:noteapp/features/note/screens/update_note.dart';
import 'package:noteapp/features/note_version/screens/note_version_history.dart';
import 'package:noteapp/features/otp_verification/screens/otp_verification.dart';
import 'package:noteapp/features/otp_verification/screens/otp_verify_success_screen.dart';
import 'package:noteapp/features/reset_password/screens/reset_password_email_screen.dart';
import 'package:noteapp/features/reset_password/screens/reset_password_otp_screen.dart';
import 'package:noteapp/features/reset_password/screens/reset_password_screen.dart';
import 'package:noteapp/features/reset_password/screens/reset_password_success_screen.dart';
import 'package:noteapp/features/sign_up/screens/signup_screen.dart';
import 'package:noteapp/features/sign_up/screens/user_information_input_screen.dart';
import 'package:noteapp/core/routes/route_paths.dart';
import 'package:noteapp/features/tags/screens/add_tag_screen.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case RoutePaths.splashScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const SSSApp(),
      //   );

      case RoutePaths.customSearchListView:
        final Map typeArgs = args as Map;
        return MaterialPageRoute(
          builder:
              (_) => CustomSearchListView(
                options: typeArgs['options'],
                title: typeArgs['label'],
                showSearch: typeArgs['showSearch'],
              ),
        );
      case RoutePaths.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutePaths.resetPasswordOTPScreen:
        args as Map;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordOTPScreen(email: args['email']),
        );
      case RoutePaths.resetPasswordEmailScreen:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordEmailScreen(),
        );

      case RoutePaths.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RoutePaths.oTPVerifySuccessScreen:
        args as Map;
        return MaterialPageRoute(
          builder:
              (_) => OTPVerifySuccessScreen(
                navigatorPath: args["navigatorPath"],
                otpNumber: args['otpNumber'] ?? "",
              ),
        );
      case RoutePaths.oTPVerificationScreen:
        args as Map;
        return MaterialPageRoute(
          builder: (_) => OTPVerificationScreen(email: args['email']),
        );
      case RoutePaths.userInformationInputScreen:
        return MaterialPageRoute(
          builder: (_) => const UserInformationInputScreen(),
        );
      case RoutePaths.resetPasswordSuccessScreen:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordSuccessScreen(),
        );
      case RoutePaths.resetPasswordScreen:
        args as Map;
        return MaterialPageRoute(
          builder:
              (_) => ResetPasswordScreen(
                otpNumber: args['otpNumber'],
                email: args['email'] ?? '',
              ),
        );

      case RoutePaths.addNote:
        return MaterialPageRoute(builder: (_) => AddNoteScreen());

      case RoutePaths.updateNote:
        return MaterialPageRoute(builder: (_) => UpdateNoteScreen());
      case RoutePaths.noteVersionHistory:
        return MaterialPageRoute(builder: (_) => NoteVersionHistory());

      case RoutePaths.collaborationSharing:
        return MaterialPageRoute(builder: (_) => CollaborationSharingScreen());

      case RoutePaths.addTag:
        return MaterialPageRoute(builder: (_) => AddTagScreen());
      case RoutePaths.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const ErrorPage();
          },
        );
    }
  }
}
