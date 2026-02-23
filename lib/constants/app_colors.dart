import 'package:flutter/material.dart';

// class ColorPalette {
//   static MaterialColor brand = MaterialColorPalette.brand;
//   static MaterialColor brand2 = MaterialColorPalette.brand2;
//   static MaterialColor red = MaterialColorPalette.red;
//   static MaterialColor neutral = MaterialColorPalette.neutral;
//   static MaterialColor orange = MaterialColorPalette.orange;
//   static MaterialColor amber = MaterialColorPalette.amber;
//   static MaterialColor green = MaterialColorPalette.green;
//   static MaterialColor emerald = MaterialColorPalette.emerald;
//   static MaterialColor teal = MaterialColorPalette.teal;
//   static MaterialColor sky = MaterialColorPalette.sky;
//   static MaterialColor indigo = MaterialColorPalette.indigo;
//   static MaterialColor violet = MaterialColorPalette.violet;
//   static MaterialColor fuchsia = MaterialColorPalette.fuchsia;
//   static MaterialColor rose = MaterialColorPalette.rose;
//   static MaterialColor slate = MaterialColorPalette.slate;
//   static MaterialColor zinc = MaterialColorPalette.zinc;
//   static MaterialColor blue = MaterialColorPalette.blue;
//   static MaterialColor white = MaterialColorPalette.white;
// }

/// - [brightSky] - Primary blue color (#1DCDFE main)
/// - [healingGreen] - Primary green color (#34F5C6 main)
///
/// Neutral Colors:
/// - [clinicCloud] - Neutral gray palette (#EDEDED main)
/// - [supporting2] - Dark neutral palette (#272828 main)
///
/// Accent Colors:
/// - [supporting] - Yellow/Gold accent (#F4CC73 main)
///
/// Semantic Colors:
/// - [success] - Success states (#00BC7D main)
/// - [error] - Error states (#FB2C36 main)
/// - [warning] - Warning states (#FE9A00 main)
/// - [info] - Info states (#00A6F4 main)
/// ============================================================================
class ColorPalete {
  // Legacy brand color
  static MaterialColor brand = MaterialColorPalette.brand;

  static MaterialColor slate = MaterialColorPalette.slate;
  static MaterialColor white = MaterialColorPalette.white;
  static MaterialColor green = MaterialColorPalette.green;
  static MaterialColor red = MaterialColorPalette.red;
  static MaterialColor zinc = MaterialColorPalette.zinc;

  static MaterialColor neutral = MaterialColorPalette.neutral;

  // Primary Colors
  static MaterialColor brightSky = MaterialColorPalette.brightSky;
  static MaterialColor healingGreen = MaterialColorPalette.healingGreen;

  // Neutral Colors
  static MaterialColor clinicCloud = MaterialColorPalette.clinicCloud;
  static MaterialColor supporting2 = MaterialColorPalette.supporting2;

  // Accent Colors
  static MaterialColor supporting = MaterialColorPalette.supporting;

  // Semantic Colors
  static MaterialColor success = MaterialColorPalette.success;
  static MaterialColor error = MaterialColorPalette.error;
  static MaterialColor warning = MaterialColorPalette.warning;
  static MaterialColor info = MaterialColorPalette.info;
}

/// ============================================================================
/// App Colors - Quick Access to Common Colors
/// ============================================================================
/// Provides static color constants for frequently used colors.
/// For full color palettes with shades, use [ColorPalete] class.
/// ============================================================================
class AppColor {
  // Legacy colors
  static const Color appThemeColor = Color(0xFF034F9E);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Colors.grey;
  static const Color redLightColor = Color(0xFFEF5350);
  static const Color redColor = Colors.red;
  static const Color pageBodyColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color spalshScreenBGColor = Color(0xFF0A1733);

  // Primary Colors (Figma Design System)
  static const Color brightSkyMain = Color(0xFF1DCDFE);
  static const Color healingGreenMain = Color(0xFF34F5C6);

  // Neutral Colors (Figma Design System)
  static const Color clinicCloudMain = Color(0xFFEDEDED);
  static const Color supporting2Main = Color(0xFF272828);

  // Accent Colors (Figma Design System)
  static const Color supportingMain = Color(0xFFF4CC73);

  // Semantic Colors (Figma Design System)
  static const Color successColor = Color(0xFF00BC7D);
  static const Color errorColor = Color(0xFFFB2C36);
  static const Color warningColor = Color(0xFFFE9A00);
  static const Color infoColor = Color(0xFF00A6F4);
}

class MaterialColorPalette {
  static MaterialColor white = const MaterialColor(
    0xFFFFFFFF, // Base color (using the 500 value as primary)
    <int, Color>{500: Color(0xFFFFFFFF)},
  );

  static const MaterialColor brand = MaterialColor(
    0xFF2BCBA5, // Base color (500)
    <int, Color>{
      50: Color(0xFFE6F7F3),
      100: Color(0xFFC2EDE3),
      200: Color(0xFF9AE1D1),
      300: Color(0xFF71D5BF),
      400: Color(0xFF4FCDB1),
      500: Color(0xFF2BCBA5),
      600: Color(0xFF26B998),
      700: Color(0xFF1FA383),
      800: Color(0xFF198E6F),
      900: Color(0xFF116852),
      950: Color(0xFF0B4A3A),
    },
  );

  // ===========================================================================
  // FIGMA DESIGN SYSTEM COLORS
  // ===========================================================================

  /// Bright Sky - Primary Blue Color Palette
  /// Main color: #1DCDFE (500)
  /// Usage: Primary brand color, buttons, links, interactive elements
  static const MaterialColor brightSky = MaterialColor(
    0xFF1DCDFE, // Base color (500)
    <int, Color>{
      50: Color(0xFFD2F5FF),
      100: Color(0xFFB5EEFF),
      200: Color(0xFF82E2FF),
      300: Color(0xFF59D9FF),
      400: Color(0xFF36D2FE),
      500: Color(0xFF1DCDFE),
      600: Color(0xFF18B0DA),
      700: Color(0xFF1391B4),
      800: Color(0xFF0E718D),
      900: Color(0xFF094E61),
      950: Color(0xFF062933),
    },
  );

  /// Healing Green - Primary Green Color Palette
  /// Main color: #34F5C6 (500)
  /// Usage: Success indicators, health-related elements, positive states
  static const MaterialColor healingGreen = MaterialColor(
    0xFF34F5C6, // Base color (500)
    <int, Color>{
      50: Color(0xFFD6FDF4),
      100: Color(0xFFB8FBEA),
      200: Color(0xFF8BF9DB),
      300: Color(0xFF66F7D0),
      400: Color(0xFF47F6CA),
      500: Color(0xFF34F5C6),
      600: Color(0xFF2CD4AB),
      700: Color(0xFF23AF8C),
      800: Color(0xFF1A876B),
      900: Color(0xFF115C49),
      950: Color(0xFF0A3128),
    },
  );

  /// Clinic Cloud - Neutral Gray Color Palette
  /// Main color: #EDEDED (500)
  /// Usage: Backgrounds, borders, dividers, subtle UI elements
  static const MaterialColor clinicCloud = MaterialColor(
    0xFFEDEDED, // Base color (500)
    <int, Color>{
      50: Color(0xFFFBFBFB),
      100: Color(0xFFF7F7F7),
      200: Color(0xFFF3F3F3),
      300: Color(0xFFEFEFEF),
      400: Color(0xFFEDEDED),
      500: Color(0xFFEDEDED),
      600: Color(0xFFCACACA),
      700: Color(0xFFA4A4A4),
      800: Color(0xFF7B7B7B),
      900: Color(0xFF525252),
      950: Color(0xFF2F2F2F),
    },
  );

  /// Supporting - Yellow/Gold Accent Color Palette
  /// Main color: #F4CC73 (500)
  /// Usage: Highlights, notifications, attention-grabbing elements
  static const MaterialColor supporting = MaterialColor(
    0xFFF4CC73, // Base color (500)
    <int, Color>{
      50: Color(0xFFFDF5E3),
      100: Color(0xFFFCEFD2),
      200: Color(0xFFFAE5B3),
      300: Color(0xFFF8DA94),
      400: Color(0xFFF6D283),
      500: Color(0xFFF4CC73),
      600: Color(0xFFD2AE61),
      700: Color(0xFFAE8F4F),
      800: Color(0xFF876F3C),
      900: Color(0xFF5C4C29),
      950: Color(0xFF312917),
    },
  );

  /// Supporting 2 - Dark Neutral Color Palette
  /// Main color: #272828 (500)
  /// Usage: Text, dark backgrounds, high-contrast elements
  static const MaterialColor supporting2 = MaterialColor(
    0xFF272828, // Base color (500)
    <int, Color>{
      50: Color(0xFFD4D4D4),
      100: Color(0xFFB8B8B8),
      200: Color(0xFF9C9C9C),
      300: Color(0xFF7C7C7C),
      400: Color(0xFF5C5C5C),
      500: Color(0xFF272828),
      600: Color(0xFF212121),
      700: Color(0xFF1A1A1A),
      800: Color(0xFF131313),
      900: Color(0xFF0C0C0C),
      950: Color(0xFF080808),
    },
  );

  /// Success - Semantic Green Color Palette
  /// Main color: #00BC7D (500)
  /// Usage: Success messages, completed states, positive actions
  static const MaterialColor success = MaterialColor(
    0xFF00BC7D, // Base color (500)
    <int, Color>{
      50: Color(0xFFECFDF5),
      100: Color(0xFFD1FAE8),
      200: Color(0xFFA7F3D4),
      300: Color(0xFF6EE7BC),
      400: Color(0xFF34D9A0),
      500: Color(0xFF00BC7D),
      600: Color(0xFF00A06A),
      700: Color(0xFF008257),
      800: Color(0xFF006644),
      900: Color(0xFF004830),
      950: Color(0xFF002C22),
    },
  );

  /// Error - Semantic Red Color Palette
  /// Main color: #FB2C36 (500)
  /// Usage: Error messages, destructive actions, validation errors
  static const MaterialColor error = MaterialColor(
    0xFFFB2C36, // Base color (500)
    <int, Color>{
      50: Color(0xFFFEF2F2),
      100: Color(0xFFFEE2E2),
      200: Color(0xFFFECACA),
      300: Color(0xFFFCA5A5),
      400: Color(0xFFFC6D73),
      500: Color(0xFFFB2C36),
      600: Color(0xFFD7262F),
      700: Color(0xFFB12027),
      800: Color(0xFF8C1A1F),
      900: Color(0xFF661216),
      950: Color(0xFF460809),
    },
  );

  /// Warning - Semantic Orange Color Palette
  /// Main color: #FE9A00 (500)
  /// Usage: Warning messages, caution states, attention required
  static const MaterialColor warning = MaterialColor(
    0xFFFE9A00, // Base color (500)
    <int, Color>{
      50: Color(0xFFFFFBEB),
      100: Color(0xFFFFF5D1),
      200: Color(0xFFFFEBA8),
      300: Color(0xFFFFDE75),
      400: Color(0xFFFFCF42),
      500: Color(0xFFFE9A00),
      600: Color(0xFFDA8400),
      700: Color(0xFFB46D00),
      800: Color(0xFF8C5500),
      900: Color(0xFF633C00),
      950: Color(0xFF461901),
    },
  );

  /// Info - Semantic Blue Color Palette
  /// Main color: #00A6F4 (500)
  /// Usage: Information messages, help text, neutral notifications
  static const MaterialColor info = MaterialColor(
    0xFF00A6F4, // Base color (500)
    <int, Color>{
      50: Color(0xFFF0F9FF),
      100: Color(0xFFE0F2FE),
      200: Color(0xFFBAE6FD),
      300: Color(0xFF7DD3FC),
      400: Color(0xFF38BDF8),
      500: Color(0xFF00A6F4),
      600: Color(0xFF008DD1),
      700: Color(0xFF0073AB),
      800: Color(0xFF005A85),
      900: Color(0xFF00405E),
      950: Color(0xFF052F4A),
    },
  );

  static MaterialColor brand2 = const MaterialColor(
    0xFF538BFD, // Base color (using the 500 value as primary)
    <int, Color>{
      50: Color(0xFFD6E3FF),
      100: Color(0xFFBAD1FE),
      200: Color(0xFF98B9FE),
      300: Color(0xFF76A2FE),
      400: Color(0xFF538BFD),
      500: Color(0xFF3174FD),
      600: Color(0xFF2961D3),
      700: Color(0xFF214DA9),
      800: Color(0xFF193A7F),
      900: Color(0xFF102754),
      950: Color(0xFF0A1733),
    },
  );

  static const MaterialColor slate = MaterialColor(
    0xFF64748B, // Base color (using the 600 value as primary)
    <int, Color>{
      50: Color(0xFFF8FAFC),
      100: Color(0xFFF1F5F9),
      200: Color(0xFFE2E8F0),
      300: Color(0xFFCBD5E1),
      400: Color(0xFF94A3B8),
      500: Color(0xFF64748B),
      600: Color(0xFF475569),
      700: Color(0xFF334155),
      800: Color(0xFF1E293B),
      900: Color(0xFF0F172A),
      950: Color(0xFF020617),
    },
  );

  //////

  static MaterialColor blue = const MaterialColor(
    0xFF2196F3, // Base blue color
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
      950: Color(0xFF08357A), // Darker shade for 950
    },
  );

  static MaterialColor zinc = const MaterialColor(
    0xFF4B4F54, // Base color
    <int, Color>{
      50: Color(0xFFE3E6E7),
      100: Color(0xFFBCC0C2),
      200: Color(0xFF979C9F),
      300: Color(0xFF72777A),
      400: Color(0xFF565C5F),
      500: Color(0xFF4B4F54),
      600: Color(0xFF404548),
      700: Color(0xFF343C3F),
      800: Color(0xFF2A3033),
      900: Color(0xFF1F2527),
      950: Color(0xFF141A1D), // Darkest shade
    },
  );

  static MaterialColor red = const MaterialColor(0xFFEF4444, <int, Color>{
    50: Color(0xFFFEE2E2),
    100: Color(0xFFFECACA),
    200: Color(0xFFFCA5A5),
    300: Color(0xFFF87171),
    400: Color(0xFFEF4444),
    500: Color(0xFFDC2626),
    600: Color(0xFFB91C1C),
    700: Color(0xFF991B1B),
    800: Color(0xFF7F1D1D),
    900: Color(0xFF4C0D0D),
    950: Color(0xFF330808),
  });

  static MaterialColor neutral = const MaterialColor(0xFF737373, <int, Color>{
    50: Color(0xFFF5F5F5),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFD4D4D4),
    300: Color(0xFFA3A3A3),
    400: Color(0xFF737373),
    500: Color(0xFF737373),
    600: Color(0xFF404040),
    700: Color(0xFF262626),
    800: Color(0xFF262626),
    900: Color(0xFF0A0A0A),
    950: Color(0xFF050505),
  });

  static MaterialColor orange = const MaterialColor(0xFFF97316, <int, Color>{
    50: Color(0xFFFFEDD5),
    100: Color(0xFFFED7AA),
    200: Color(0xFFFDBA74),
    300: Color(0xFFFB923C),
    400: Color(0xFFF97316),
    500: Color(0xFFEA580C),
    600: Color(0xFFC2410C),
    700: Color(0xFF9A3412),
    800: Color(0xFF7C2D12),
    900: Color(0xFF4B1D0E),
    950: Color(0xFF311407),
  });

  static MaterialColor amber = const MaterialColor(0xFFF59E0B, <int, Color>{
    50: Color(0xFFFEF3C7),
    100: Color(0xFFFDE68A),
    200: Color(0xFFFCD34D),
    300: Color(0xFFFBBF24),
    400: Color(0xFFF59E0B),
    500: Color(0xFFD97706),
    600: Color(0xFFB45309),
    700: Color(0xFF92400E),
    800: Color(0xFF78350F),
    900: Color(0xFF451A03),
    950: Color(0xFF2E1101),
  });

  static MaterialColor green = const MaterialColor(0xFF34C759, <int, Color>{
    50: Color(0xFFD1FAE5),
    100: Color(0xFFA7F3D0),
    200: Color(0xFF6EE7B7),
    300: Color(0xFF34D399),
    400: Color(0xFF10B981),
    500: Color(0xFF34C759),
    600: Color(0xFF047857),
    700: Color(0xFF065F46),
    800: Color(0xFF064E3B),
    900: Color(0xFF022C22),
    950: Color(0xFF011711),
  });

  static MaterialColor emerald = const MaterialColor(0xFF059669, <int, Color>{
    50: Color(0xFFD1FAE5),
    100: Color(0xFFA7F3D0),
    200: Color(0xFF6EE7B7),
    300: Color(0xFF34D399),
    400: Color(0xFF10B981),
    500: Color(0xFF059669),
    600: Color(0xFF047857),
    700: Color(0xFF065F46),
    800: Color(0xFF064E3B),
    900: Color(0xFF022C22),
    950: Color(0xFF011711),
  });

  static MaterialColor teal = const MaterialColor(0xFF14B8A6, <int, Color>{
    50: Color(0xFFCCFBF1),
    100: Color(0xFF99F6E4),
    200: Color(0xFF5EEAD4),
    300: Color(0xFF2DD4BF),
    400: Color(0xFF14B8A6),
    500: Color(0xFF0D9488),
    600: Color(0xFF0F766E),
    700: Color(0xFF115E59),
    800: Color(0xFF134E4A),
    900: Color(0xFF083D36),
    950: Color(0xFF052B26),
  });

  static MaterialColor sky = const MaterialColor(0xFF0EA5E9, <int, Color>{
    50: Color(0xFFE0F2FE),
    100: Color(0xFFBAE6FD),
    200: Color(0xFF7DD3FC),
    300: Color(0xFF38BDF8),
    400: Color(0xFF0EA5E9),
    500: Color(0xFF0284C7),
    600: Color(0xFF0369A1),
    700: Color(0xFF075985),
    800: Color(0xFF0C4A6E),
    900: Color(0xFF082F49),
    950: Color(0xFF051D34),
  });

  static MaterialColor indigo = const MaterialColor(0xFF6366F1, <int, Color>{
    50: Color(0xFFE0E7FF),
    100: Color(0xFFC7D2FE),
    200: Color(0xFFA5B4FC),
    300: Color(0xFF818CF8),
    400: Color(0xFF6366F1),
    500: Color(0xFF4F46E5),
    600: Color(0xFF4338CA),
    700: Color(0xFF3730A3),
    800: Color(0xFF312E81),
    900: Color(0xFF1E1B4B),
    950: Color(0xFF111027),
  });

  static MaterialColor violet = const MaterialColor(0xFF8B5CF6, <int, Color>{
    50: Color(0xFFF5F3FF),
    100: Color(0xFFEDE9FE),
    200: Color(0xFFDDD6FE),
    300: Color(0xFFC4B5FD),
    400: Color(0xFFA78BFA),
    500: Color(0xFF8B5CF6),
    600: Color(0xFF7C3AED),
    700: Color(0xFF6D28D9),
    800: Color(0xFF5B21B6),
    900: Color(0xFF3F1C9E),
    950: Color(0xFF2B145E),
  });

  static MaterialColor fuchsia = const MaterialColor(0xFFD946EF, <int, Color>{
    50: Color(0xFFFDF4FF),
    100: Color(0xFFFAE8FF),
    200: Color(0xFFF5D0FE),
    300: Color(0xFFF0ABFC),
    400: Color(0xFFE879F9),
    500: Color(0xFFD946EF),
    600: Color(0xFFC026D3),
    700: Color(0xFFA21CAF),
    800: Color(0xFF86198F),
    900: Color(0xFF701A75),
    950: Color(0xFF4A0C4A),
  });

  static MaterialColor rose = const MaterialColor(0xFFF43F5E, <int, Color>{
    50: Color(0xFFFFF1F2),
    100: Color(0xFFFFE4E6),
    200: Color(0xFFFECDD3),
    300: Color(0xFFFDA4AF),
    400: Color(0xFFF87171),
    500: Color(0xFFF43F5E),
    600: Color(0xFFE11D48),
    700: Color(0xFFBE123C),
    800: Color(0xFF9F1239),
    900: Color(0xFF881337),
    950: Color(0xFF4E081C),
  });
}
