/// ============================================================================
/// App Font Families - Design System Typography
/// ============================================================================
///
/// Font Family Constants based on Figma Design System:
///
/// **Primary Font Family (Display/Headings):**
/// - [baloo2] - Used for display text, headings, and primary typography
/// - Characteristics: Rounded, friendly sans-serif
/// - Usage: H1-H6, display text, brand elements
///
/// **Secondary Font Family (Body/Content):**
/// - [satoshi] - Used for body text, UI elements, and secondary typography
/// - Characteristics: Modern geometric sans-serif
/// - Usage: Body text, buttons, labels, UI components
///
/// **Font Weights Available:**
/// - Light: 300
/// - Regular: 400
/// - Medium: 500
/// - SemiBold: 600 (Baloo2 only)
/// - Bold: 700
/// - ExtraBold: 800 (Baloo2 only)
/// - Black: 900 (Satoshi only)
/// ============================================================================

class AppFonts {
  /// Primary font family for display text and headings
  /// Used for: H1-H6, display text, brand elements, primary typography
  static const String baloo2 = 'Baloo2';

  /// Secondary font family for body text and UI elements
  /// Used for: Body text, buttons, labels, UI components, secondary typography
  static const String satoshi = 'Satoshi';
}

/// ============================================================================
/// Font Family Extensions for Typography System
/// ============================================================================
/// Provides convenient extensions for applying font families based on
/// design system hierarchy and usage patterns.
/// ============================================================================

extension AppFontExtensions on String {
  /// Apply Baloo2 font family (Primary/Display)
  String get withBaloo2 => AppFonts.baloo2;

  /// Apply Satoshi font family (Secondary/Body)
  String get withSatoshi => AppFonts.satoshi;
}

/// ============================================================================
/// Typography Font Family Helpers
/// ============================================================================
/// Helper methods for getting appropriate font families based on text type
/// ============================================================================

// class FontFamilyHelper {
//   /// Get font family for display text (large, prominent text)
//   static String get displayFont => AppFonts.baloo2;

//   /// Get font family for heading text (H1-H6)
//   static String get headingFont => AppFonts.baloo2;

//   /// Get font family for body text (paragraphs, content)
//   static String get bodyFont => AppFonts.satoshi;

//   /// Get font family for UI elements (buttons, labels)
//   static String get uiFont => AppFonts.satoshi;

//   /// Get font family for captions and small text
//   static String get captionFont => AppFonts.satoshi;

//   /// Get fallback font family
//   static String get fallbackFont => AppFonts.sansSerif;
// }

/// ============================================================================
/// Design System Font Family Mapping
/// ============================================================================
/// Direct mapping from Figma design system typography styles
/// ============================================================================

class DesignSystemFonts {
  // Display Typography (Baloo2)
  static const String displayPrimary = AppFonts.baloo2;
  static const String displaySecondary = AppFonts.baloo2;

  // Heading Typography (Baloo2)
  static const String heading1 = AppFonts.baloo2;
  static const String heading2 = AppFonts.baloo2;
  static const String heading3 = AppFonts.baloo2;
  static const String heading4 = AppFonts.baloo2;
  static const String heading5 = AppFonts.baloo2;

  // Body Typography (Satoshi)
  static const String largeBody = AppFonts.satoshi;
  static const String baseBody = AppFonts.satoshi;
  static const String smallBody = AppFonts.satoshi;

  // Caption Typography (Satoshi)
  static const String footnote = AppFonts.satoshi;
  static const String footnoteLarge = AppFonts.satoshi;
  static const String footnoteExtraLarge = AppFonts.satoshi;
  static const String labelCap = AppFonts.satoshi;
}
