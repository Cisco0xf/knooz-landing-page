
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/my_logger.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_management.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_model.dart';
import 'package:knooz_docs_api/presentations/web_view/top_bar/top_bar_section.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

class WebViewLayout extends ConsumerStatefulWidget {
  const WebViewLayout({super.key});

  @override
  ConsumerState<WebViewLayout> createState() => _WebViewLayoutState();
}

class _WebViewLayoutState extends ConsumerState<WebViewLayout> {
  double dx = 0.0;
  double dy = 0.0;

  bool hasMouse = false;
  @override
  Widget build(BuildContext context) {
    final int currentNav = ref.watch(tabsNavProvider);

    final bool isDark = ref.watch(themeProvider);

    final bool showTracker = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux);

    Log.log("Current Screen Width => ${context.screenWidth}");
    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          setState(
            () {
              dy = event.localPosition.dy;
              dx = event.localPosition.dx;
            },
          );
        },
        child: Stack(
          children: [
            if (showTracker)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                top: dy - (context.screenWidth * .2) / 2,
                left: dx - (context.screenWidth * .2) / 2,
                child: SizedBox.square(
                  dimension: context.screenWidth * .2,
                  child: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? DarkColors.primaryColor.withOpacity(0.05)
                            : Colors.transparent,
                        blurRadius: 100,
                        offset: const Offset(0, 0),
                        spreadRadius: 0.5,
                      ),
                    ]),
                  ),
                ),
              ),
            if (showTracker)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                top: dy - (4.5),
                left: dx - (4.5),
                child: Container(
                  padding: padding(7.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isDark ? Colors.white30 : Colors.green.withOpacity(0.5),
                  ),
                ),
              ),
            Positioned.fill(
              child: Column(
                children: <Widget>[
                  if (context.isTablet /* || Platform.isAndroid */)
                    const Gap(hRatio: 0.03),
                  const TopBarSection(),
                  // Divider(),
                  mainTabs[currentNav].navigation,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
