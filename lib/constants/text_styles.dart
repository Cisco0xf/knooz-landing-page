import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/constants/colors.dart';

class TextStyles {
  static TextStyle carioStyle({
    Color? color,
    double? fontSize,
    bool fontWeight = false,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.cairo(
      color: color,
      letterSpacing: 0.0,
      fontWeight: fontWeight ? FontWeight.bold : null,
      fontSize: fontSize,
      shadows: shadows,
    );
  }

  static TextStyle cairoTitle() {
    return GoogleFonts.cairo(
      color: SwitchColors.textColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.0,
      fontSize: 25,
    );
  }
}

double fontSize(BuildContext context, double size) {
  if (context.isMobile) {
    return (size * 0.8);
  }

  return size;
}
