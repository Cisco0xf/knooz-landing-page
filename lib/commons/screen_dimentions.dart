import 'package:flutter/material.dart';

extension ScreenDimentions on BuildContext {
  double get screenHeight {
    final double height = MediaQuery.sizeOf(this).height;

    return height;
  }

  double get screenWidth {
    final double width = MediaQuery.sizeOf(this).width;

    return width;
  }

  bool get isMobile => screenWidth < Breakpoints.mobile;

  bool get isDesktop => screenWidth >= Breakpoints.desktop;

  bool get isTablet =>
      screenWidth > Breakpoints.mobile && screenWidth < Breakpoints.desktop;
}

class Breakpoints {
  static const double mobile = 855; // 0 - 600px
  static const double tablet = 900; // 601 - 900px
  static const double desktop = 1200; // 901 - 1200px
  static const double ultraWide = 1800; // 1201+
}
