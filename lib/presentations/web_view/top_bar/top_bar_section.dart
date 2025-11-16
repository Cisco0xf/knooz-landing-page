import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knooz_docs_api/commons/sizes.dart';
import 'package:knooz_docs_api/constants/assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/texts.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/navigation_tabs.dart';
import 'package:knooz_docs_api/presentations/web_view/top_bar/mode_switcher.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

class TopBarSection extends ConsumerWidget {
  const TopBarSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: MainIcon(),
        ),
        Expanded(flex: 7, child: NavigationTabs()),
        Expanded(flex: 2, child: ModeSwitcher()),
      ],
    );
  }
}

class MainIcon extends ConsumerWidget {
  const MainIcon({super.key, this.titleSize = 30});

  final double titleSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return Row(
      children: <Widget>[
        SizedBox.square(
          dimension:
              WidgetsSize.logoSize(context) /* context.screenWidth * .05 */,
          child: Image.network(AppImage.appLogoPng),
        ),
        Text(
          appName,
          style: GoogleFonts.cairo(
            color: SwitchColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: titleSize,
          ),
        ),
      ],
    );
  }
}
