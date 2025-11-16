import 'package:flutter/material.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/presentations/mobile_view/mobile_view.dart';
import 'package:knooz_docs_api/presentations/web_view/web_view.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (context.isMobile) {
            return const MobileViewLayout();
          }

          return const WebViewLayout();
        },
      ),
    );
  }
}
