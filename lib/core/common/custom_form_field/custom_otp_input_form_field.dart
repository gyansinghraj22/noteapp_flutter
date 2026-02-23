import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:noteapp/constants/app_colors.dart';

typedef OnCodeEnteredCompletion = void Function(String value);
typedef OnCodeChanged = void Function(String value);

class CustomOtpInputFormField extends StatefulWidget {
  final int numberOfFields;
  final double fieldWidth;
  final double borderRadius;
  final double fieldHeight;
  final bool autoFocus;
  final TextStyle textStyle;
  final Color focusedBorderColor;
  final Color fillColor;
  final Color borderColor;
  final bool? obscureText;
  final Function(String) onChanged;
  final Function(String) onCompleted;
  final TextEditingController otpController;
  final FocusNode? focusNodeWidget;

  const CustomOtpInputFormField({
    super.key,
    required this.numberOfFields,
    required this.fieldWidth,
    required this.fieldHeight,
    required this.autoFocus,
    required this.textStyle,
    required this.focusedBorderColor,
    required this.fillColor,
    required this.borderColor,
    required this.onChanged,
    required this.onCompleted,
    required this.otpController,
    required this.borderRadius,
    this.focusNodeWidget,
    this.obscureText = false,
  });

  @override
  State<CustomOtpInputFormField> createState() =>
      _CustomOtpInputFormFieldState();
}

class _CustomOtpInputFormFieldState extends State<CustomOtpInputFormField> {
  final pinController = TextEditingController();
  late var focusNode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    focusNode = widget.focusNodeWidget ?? FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    if (widget.focusNodeWidget == null) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: widget.fieldWidth,
      height: widget.fieldHeight,
      textStyle: widget.textStyle,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 229, 245),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        // border: Border.all(color: widget.borderColor),
      ),
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        autofocus: widget.autoFocus,
        length: widget.numberOfFields,
        obscureText: widget.obscureText ?? false,
        controller: widget.otpController,
        showCursor: true,
        focusNode: focusNode,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        // listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: widget.onCompleted,
        onChanged: widget.onChanged,
        focusedPinTheme: defaultPinTheme,
        submittedPinTheme: defaultPinTheme,
        validator: (value) {
          return checkValidation(value.toString());
        },
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
        errorTextStyle: const TextStyle(fontSize: 12, color: AppColor.redColor),
        errorText: "Pin must be ${widget.numberOfFields} digits",
      ),
    );
  }

  checkValidation(String value) {
    if (value.isEmpty) {
      return "Enter Pin";
    }
    if (value.length != widget.numberOfFields) {
      return "Pin must be ${widget.numberOfFields} digits";
    }
  }
}
