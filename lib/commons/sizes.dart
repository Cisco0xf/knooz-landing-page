import 'package:flutter/material.dart';
import 'package:knooz_docs_api/commons/navigator_key.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';

class WidgetsSize {
  static final BuildContext _context =
      navigatorKey.currentContext as BuildContext;

  static double logoSize(BuildContext context) {
    if (context.isMobile) {
      return context.screenHeight * .07;
    }

    return context.screenWidth * .05;
  }

  static (double width, double height) mainMockupSize(BuildContext context) {
    if (context.isMobile) {
      return (
        context.screenWidth * .46,
        context.screenHeight * .35,
      );
    }

    return (
      context.screenWidth * .25,
      context.screenHeight * .5,
    );
  }

  static double buttonWidth(BuildContext context) {
    if (context.isMobile) {
      return context.screenWidth * .5;
    }
    return context.screenWidth * .17;
  }

  static (double width, double height) animtedImageSize(BuildContext context) {
    if (context.isMobile) {
      return (
        context.screenWidth * .36,
        context.screenHeight * .3,
      );
    }
    return (
      context.screenWidth * .13,
      context.screenHeight * .5,
    );
  }

  static double? downloadSectionWidth(BuildContext context) {
    if (context.isMobile) {
      return null;
    }

    return context.screenWidth * .4;
  }
}
