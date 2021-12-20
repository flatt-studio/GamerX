import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFF4DB945);
  static const Color secondaryColor = Color(0xFF222E3D);
  static const Color tertiaryColor = Color(0xFFFFFFFF);

  static const Color customColor1 = Color(0xFF47924B);
  static const Color customColor2 = Color(0xFFFF3D00);
  static const Color customColor3 = Color(0xFF8E8E8E);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';
  static TextStyle get title1 => GoogleFonts.getFont(
        'Roboto',
        color: tertiaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Roboto',
        color: tertiaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Roboto',
        color: tertiaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Roboto',
        color: tertiaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Roboto',
        color: tertiaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Roboto',
        color: tertiaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Roboto',
        color: tertiaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 11,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
            );
}
