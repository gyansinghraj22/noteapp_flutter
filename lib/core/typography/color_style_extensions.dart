import 'package:flutter/material.dart';
import 'package:noteapp/constants/app_colors.dart';

extension ColorStyleExtensions on TextStyle {
  /// ========================================================================
  /// Primary Brand Colors
  /// ========================================================================

  /// Apply Bright Sky color (Primary Blue - #1DCDFE)
  TextStyle get brightSky => copyWith(color: AppColor.brightSkyMain);

  /// Apply Bright Sky color variations
  TextStyle get brightSky50 => copyWith(color: ColorPalete.brightSky[50]);
  TextStyle get brightSky100 => copyWith(color: ColorPalete.brightSky[100]);
  TextStyle get brightSky200 => copyWith(color: ColorPalete.brightSky[200]);
  TextStyle get brightSky300 => copyWith(color: ColorPalete.brightSky[300]);
  TextStyle get brightSky400 => copyWith(color: ColorPalete.brightSky[400]);
  TextStyle get brightSky500 =>
      copyWith(color: ColorPalete.brightSky[500]); // Main
  TextStyle get brightSky600 => copyWith(color: ColorPalete.brightSky[600]);
  TextStyle get brightSky700 => copyWith(color: ColorPalete.brightSky[700]);
  TextStyle get brightSky800 => copyWith(color: ColorPalete.brightSky[800]);
  TextStyle get brightSky900 => copyWith(color: ColorPalete.brightSky[900]);
  TextStyle get brightSky950 => copyWith(color: ColorPalete.brightSky[950]);

  /// Apply Healing Green color (Primary Green - #34F5C6)
  TextStyle get healingGreen => copyWith(color: AppColor.healingGreenMain);

  /// Apply Healing Green color variations
  TextStyle get healingGreen50 => copyWith(color: ColorPalete.healingGreen[50]);
  TextStyle get healingGreen100 =>
      copyWith(color: ColorPalete.healingGreen[100]);
  TextStyle get healingGreen200 =>
      copyWith(color: ColorPalete.healingGreen[200]);
  TextStyle get healingGreen300 =>
      copyWith(color: ColorPalete.healingGreen[300]);
  TextStyle get healingGreen400 =>
      copyWith(color: ColorPalete.healingGreen[400]);
  TextStyle get healingGreen500 =>
      copyWith(color: ColorPalete.healingGreen[500]); // Main
  TextStyle get healingGreen600 =>
      copyWith(color: ColorPalete.healingGreen[600]);
  TextStyle get healingGreen700 =>
      copyWith(color: ColorPalete.healingGreen[700]);
  TextStyle get healingGreen800 =>
      copyWith(color: ColorPalete.healingGreen[800]);
  TextStyle get healingGreen900 =>
      copyWith(color: ColorPalete.healingGreen[900]);
  TextStyle get healingGreen950 =>
      copyWith(color: ColorPalete.healingGreen[950]);

  /// ========================================================================
  /// Neutral Colors
  /// ========================================================================

  /// Apply Clinic Cloud color (Neutral Gray - #EDEDED)
  TextStyle get clinicCloud => copyWith(color: AppColor.clinicCloudMain);

  /// Apply Clinic Cloud color variations
  TextStyle get clinicCloud50 => copyWith(color: ColorPalete.clinicCloud[50]);
  TextStyle get clinicCloud100 => copyWith(color: ColorPalete.clinicCloud[100]);
  TextStyle get clinicCloud200 => copyWith(color: ColorPalete.clinicCloud[200]);
  TextStyle get clinicCloud300 => copyWith(color: ColorPalete.clinicCloud[300]);
  TextStyle get clinicCloud400 => copyWith(color: ColorPalete.clinicCloud[400]);
  TextStyle get clinicCloud500 =>
      copyWith(color: ColorPalete.clinicCloud[500]); // Main
  TextStyle get clinicCloud600 => copyWith(color: ColorPalete.clinicCloud[600]);
  TextStyle get clinicCloud700 => copyWith(color: ColorPalete.clinicCloud[700]);
  TextStyle get clinicCloud800 => copyWith(color: ColorPalete.clinicCloud[800]);
  TextStyle get clinicCloud900 => copyWith(color: ColorPalete.clinicCloud[900]);
  TextStyle get clinicCloud950 => copyWith(color: ColorPalete.clinicCloud[950]);

  /// Apply Supporting 2 color (Dark Neutral - #272828)
  TextStyle get supporting2 => copyWith(color: AppColor.supporting2Main);

  /// Apply Supporting 2 color variations
  TextStyle get supporting2_50 => copyWith(color: ColorPalete.supporting2[50]);
  TextStyle get supporting2_100 =>
      copyWith(color: ColorPalete.supporting2[100]);
  TextStyle get supporting2_200 =>
      copyWith(color: ColorPalete.supporting2[200]);
  TextStyle get supporting2_300 =>
      copyWith(color: ColorPalete.supporting2[300]);
  TextStyle get supporting2_400 =>
      copyWith(color: ColorPalete.supporting2[400]);
  TextStyle get supporting2_500 =>
      copyWith(color: ColorPalete.supporting2[500]); // Main
  TextStyle get supporting2_600 =>
      copyWith(color: ColorPalete.supporting2[600]);
  TextStyle get supporting2_700 =>
      copyWith(color: ColorPalete.supporting2[700]);
  TextStyle get supporting2_800 =>
      copyWith(color: ColorPalete.supporting2[800]);
  TextStyle get supporting2_900 =>
      copyWith(color: ColorPalete.supporting2[900]);
  TextStyle get supporting2_950 =>
      copyWith(color: ColorPalete.supporting2[950]);

  /// ========================================================================
  /// Accent Colors
  /// ========================================================================

  /// Apply Supporting color (Yellow/Gold - #F4CC73)
  TextStyle get supporting => copyWith(color: AppColor.supportingMain);

  /// Apply Supporting color variations
  TextStyle get supporting50 => copyWith(color: ColorPalete.supporting[50]);
  TextStyle get supporting100 => copyWith(color: ColorPalete.supporting[100]);
  TextStyle get supporting200 => copyWith(color: ColorPalete.supporting[200]);
  TextStyle get supporting300 => copyWith(color: ColorPalete.supporting[300]);
  TextStyle get supporting400 => copyWith(color: ColorPalete.supporting[400]);
  TextStyle get supporting500 =>
      copyWith(color: ColorPalete.supporting[500]); // Main
  TextStyle get supporting600 => copyWith(color: ColorPalete.supporting[600]);
  TextStyle get supporting700 => copyWith(color: ColorPalete.supporting[700]);
  TextStyle get supporting800 => copyWith(color: ColorPalete.supporting[800]);
  TextStyle get supporting900 => copyWith(color: ColorPalete.supporting[900]);
  TextStyle get supporting950 => copyWith(color: ColorPalete.supporting[950]);

  /// ========================================================================
  /// Semantic Colors
  /// ========================================================================

  /// Apply Success color (#00BC7D)
  TextStyle get success => copyWith(color: AppColor.successColor);

  /// Apply Success color variations
  TextStyle get success50 => copyWith(color: ColorPalete.success[50]);
  TextStyle get success100 => copyWith(color: ColorPalete.success[100]);
  TextStyle get success200 => copyWith(color: ColorPalete.success[200]);
  TextStyle get success300 => copyWith(color: ColorPalete.success[300]);
  TextStyle get success400 => copyWith(color: ColorPalete.success[400]);
  TextStyle get success500 => copyWith(color: ColorPalete.success[500]); // Main
  TextStyle get success600 => copyWith(color: ColorPalete.success[600]);
  TextStyle get success700 => copyWith(color: ColorPalete.success[700]);
  TextStyle get success800 => copyWith(color: ColorPalete.success[800]);
  TextStyle get success900 => copyWith(color: ColorPalete.success[900]);
  TextStyle get success950 => copyWith(color: ColorPalete.success[950]);

  /// Apply Error color (#FB2C36)
  TextStyle get error => copyWith(color: AppColor.errorColor);

  /// Apply Error color variations
  TextStyle get error50 => copyWith(color: ColorPalete.error[50]);
  TextStyle get error100 => copyWith(color: ColorPalete.error[100]);
  TextStyle get error200 => copyWith(color: ColorPalete.error[200]);
  TextStyle get error300 => copyWith(color: ColorPalete.error[300]);
  TextStyle get error400 => copyWith(color: ColorPalete.error[400]);
  TextStyle get error500 => copyWith(color: ColorPalete.error[500]); // Main
  TextStyle get error600 => copyWith(color: ColorPalete.error[600]);
  TextStyle get error700 => copyWith(color: ColorPalete.error[700]);
  TextStyle get error800 => copyWith(color: ColorPalete.error[800]);
  TextStyle get error900 => copyWith(color: ColorPalete.error[900]);
  TextStyle get error950 => copyWith(color: ColorPalete.error[950]);

  /// Apply Warning color (#FE9A00)
  TextStyle get warning => copyWith(color: AppColor.warningColor);

  /// Apply Warning color variations
  TextStyle get warning50 => copyWith(color: ColorPalete.warning[50]);
  TextStyle get warning100 => copyWith(color: ColorPalete.warning[100]);
  TextStyle get warning200 => copyWith(color: ColorPalete.warning[200]);
  TextStyle get warning300 => copyWith(color: ColorPalete.warning[300]);
  TextStyle get warning400 => copyWith(color: ColorPalete.warning[400]);
  TextStyle get warning500 => copyWith(color: ColorPalete.warning[500]); // Main
  TextStyle get warning600 => copyWith(color: ColorPalete.warning[600]);
  TextStyle get warning700 => copyWith(color: ColorPalete.warning[700]);
  TextStyle get warning800 => copyWith(color: ColorPalete.warning[800]);
  TextStyle get warning900 => copyWith(color: ColorPalete.warning[900]);
  TextStyle get warning950 => copyWith(color: ColorPalete.warning[950]);

  /// Apply Info color (#00A6F4)
  TextStyle get info => copyWith(color: AppColor.infoColor);

  /// Apply Info color variations
  TextStyle get info50 => copyWith(color: ColorPalete.info[50]);
  TextStyle get info100 => copyWith(color: ColorPalete.info[100]);
  TextStyle get info200 => copyWith(color: ColorPalete.info[200]);
  TextStyle get info300 => copyWith(color: ColorPalete.info[300]);
  TextStyle get info400 => copyWith(color: ColorPalete.info[400]);
  TextStyle get info500 => copyWith(color: ColorPalete.info[500]); // Main
  TextStyle get info600 => copyWith(color: ColorPalete.info[600]);
  TextStyle get info700 => copyWith(color: ColorPalete.info[700]);
  TextStyle get info800 => copyWith(color: ColorPalete.info[800]);
  TextStyle get info900 => copyWith(color: ColorPalete.info[900]);
  TextStyle get info950 => copyWith(color: ColorPalete.info[950]);

  /// ========================================================================
  /// Common/Legacy Colors
  /// ========================================================================

  /// Apply common colors
  TextStyle get white => copyWith(color: AppColor.whiteColor);
  TextStyle get black => copyWith(color: AppColor.blackColor);
  TextStyle get grey => copyWith(color: AppColor.greyColor);
  TextStyle get red => copyWith(color: AppColor.redColor);
  TextStyle get redLight => copyWith(color: AppColor.redLightColor);
  TextStyle get appTheme => copyWith(color: AppColor.appThemeColor);

  /// ========================================================================
  /// Material Color Palette Extensions
  /// ========================================================================

  /// Apply Material Color Palette variations
  TextStyle get slate50 => copyWith(color: ColorPalete.slate[50]);
  TextStyle get slate100 => copyWith(color: ColorPalete.slate[100]);
  TextStyle get slate200 => copyWith(color: ColorPalete.slate[200]);
  TextStyle get slate300 => copyWith(color: ColorPalete.slate[300]);
  TextStyle get slate400 => copyWith(color: ColorPalete.slate[400]);
  TextStyle get slate500 => copyWith(color: ColorPalete.slate[500]);
  TextStyle get slate600 => copyWith(color: ColorPalete.slate[600]);
  TextStyle get slate700 => copyWith(color: ColorPalete.slate[700]);
  TextStyle get slate800 => copyWith(color: ColorPalete.slate[800]);
  TextStyle get slate900 => copyWith(color: ColorPalete.slate[900]);

  /// Apply Neutral Color variations
  TextStyle get neutral50 => copyWith(color: ColorPalete.neutral[50]);
  TextStyle get neutral100 => copyWith(color: ColorPalete.neutral[100]);
  TextStyle get neutral200 => copyWith(color: ColorPalete.neutral[200]);
  TextStyle get neutral300 => copyWith(color: ColorPalete.neutral[300]);
  TextStyle get neutral400 => copyWith(color: ColorPalete.neutral[400]);
  TextStyle get neutral500 => copyWith(color: ColorPalete.neutral[500]);
  TextStyle get neutral600 => copyWith(color: ColorPalete.neutral[600]);
  TextStyle get neutral700 => copyWith(color: ColorPalete.neutral[700]);
  TextStyle get neutral800 => copyWith(color: ColorPalete.neutral[800]);
  TextStyle get neutral900 => copyWith(color: ColorPalete.neutral[900]);
}

/// ============================================================================
/// Semantic Color Extensions (Alternative Naming)
/// ============================================================================
/// Additional semantic color aliases for better readability
/// ============================================================================

extension SemanticColorExtensions on TextStyle {
  /// Positive/Success states
  TextStyle get positive => success;
  TextStyle get successLight => success100;
  TextStyle get successDark => success800;

  /// Negative/Error states
  TextStyle get negative => error;
  TextStyle get danger => error;
  TextStyle get destructive => error;
  TextStyle get errorLight => error100;
  TextStyle get errorDark => error800;

  /// Warning/Caution states
  TextStyle get caution => warning;
  TextStyle get attention => warning;
  TextStyle get warningLight => warning100;
  TextStyle get warningDark => warning800;

  /// Information states
  TextStyle get information => info;
  TextStyle get infoLight => info100;
  TextStyle get infoDark => info800;

  /// Primary brand states
  TextStyle get primary => brightSky;
  TextStyle get primaryLight => brightSky100;
  TextStyle get primaryDark => brightSky800;

  /// Secondary brand states
  TextStyle get secondary => healingGreen;
  TextStyle get secondaryLight => healingGreen100;
  TextStyle get secondaryDark => healingGreen800;

  /// Text hierarchy
  TextStyle get textPrimary => supporting2_900; // Darkest text
  TextStyle get textSecondary => supporting2_700; // Medium text
  TextStyle get textTertiary => supporting2_500; // Light text
  TextStyle get textDisabled => neutral400; // Disabled text
  TextStyle get textPlaceholder => neutral400; // Placeholder text

  /// Background compatible text
  TextStyle get onLight => supporting2_900; // Dark text on light backgrounds
  TextStyle get onDark => white; // Light text on dark backgrounds
  TextStyle get onPrimary => white; // Text on primary colored backgrounds
  TextStyle get onSecondary => white; // Text on secondary colored backgrounds
}

/// ============================================================================
/// Usage Examples & Documentation
/// ============================================================================
/// 
/// Basic Usage:
/// ```dart
/// Text('Hello World', style: TextStyle().brightSky)
/// Text('Success!', style: bodyLarge.success)
/// Text('Warning', style: headline1.warning.bold)
/// ```
/// 
/// Semantic Usage:
/// ```dart
/// Text('Error Message', style: bodyMedium.danger)
/// Text('Success Message', style: bodyMedium.positive)
/// Text('Primary Action', style: buttonLarge.primary)
/// ```
/// 
/// Hierarchical Text:
/// ```dart
/// Text('Main Title', style: headline1.textPrimary)
/// Text('Subtitle', style: headline2.textSecondary)
/// Text('Body Text', style: bodyLarge.textTertiary)
/// Text('Disabled Text', style: bodyMedium.textDisabled)
/// ```
/// 
/// Brand Colors:
/// ```dart
/// Text('Brand Text', style: headline1.brightSky)
/// Text('Secondary Text', style: bodyLarge.healingGreen)
/// Text('Accent Text', style: bodyMedium.supporting)
/// ```
/// ============================================================================
