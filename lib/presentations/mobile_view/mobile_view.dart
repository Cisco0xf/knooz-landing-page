import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/enums.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/constants/texts.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_management.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_model.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/about_section/about_model.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/about_section/about_sections.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/dev_section/developer_section.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/download_section/download_section.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/home_section/home_section.dart';
import 'package:knooz_docs_api/presentations/web_view/top_bar/mode_switcher.dart';
import 'package:knooz_docs_api/presentations/web_view/top_bar/top_bar_section.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

class MobileViewLayout extends ConsumerWidget {
  const MobileViewLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int target = ref.watch(tabsNavProvider);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const MobileAppBar(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    //top: context.screenHeight * .12,
                    child: mainTabs[target].mobileNav,
                  ),
                  const Positioned(
                    bottom: 10.0,
                    right: 7.0,
                    left: 7.0,
                    child: MobileMainNavigation(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Main App Bar

class MobileAppBar extends ConsumerWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return ColoredBox(
      color: SwitchColors.backgroundColor,
      child: Column(
        children: [
          const Gap(height: 15.0),
          Padding(
            padding: padding(15.0, from: From.horizontal),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainIcon(
                  titleSize: 25.0,
                ),
                ModeSwitcher(),
              ],
            ),
          ),
          const Gap(height: 10.0),
        ],
      ),
    );
  }
}

// Main Bottom navigation Bar

class MobileMainNavigation extends ConsumerWidget {
  const MobileMainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentnav = ref.watch(tabsNavProvider);
    ref.watch(themeProvider);
    return ClipRRect(
      borderRadius: borderRadius(40.0),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius(40.0),
              border: Border.all(color: SwitchColors.borderColor),
              color: SwitchColors.secondaryColor.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(mainTabs.length, (index) {
                return NavItem(
                  isSelected: currentnav == index,
                  onSelect: () {
                    ref.read(tabsNavProvider.notifier).navigateTo(index);
                  },
                  tab: mainTabs[index],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.tab,
  });
  final TabsModel tab;
  final bool isSelected;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return Clicker(
      onTap: onSelect,
      innerPadding: 4.0,
      child: Column(
        children: [
          Container(
            padding: padding(7.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? SwitchColors.primaryColor
                    : SwitchColors.borderColor,
              ),
            ),
            child: Icon(
              tab.icons,
              color: isSelected ? SwitchColors.primaryColor : null,
            ),
          ),
          const Gap(height: 3.0),
          Text(
            tab.title,
            style: TextStyles.carioStyle(
              color: isSelected ? SwitchColors.primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }
}

// MobileHome Screen

class MobileHomsScreen extends ConsumerWidget {
  const MobileHomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider);

    final bool good = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux);
    return SingleChildScrollView(
      padding: padding(10.0, from: From.horizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /*  SizedBox.square(
            dimension: context.screenHeight * .2,
            child: Image.network(AppImage.appLogoPng),
          ), */
          AnimatedMockupImages(isDark: isDark),
          Padding(
            padding: padding(10.0, from: From.horizontal),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.handshakeAngle),
                const Gap(width: 5.0),
                Expanded(
                  child: Text(
                    welcomeText,
                    style: TextStyles.carioStyle(
                      fontSize: 20,
                      fontWeight: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(height: 10),
          const WelcomeTyper(
            fontSize: 18,
            fontWeight: false,
          ),
          const Gap(height: 10),
          // AnimatedMockupImages(isDark: isDark),
          const AnimatedMainText(isMobile: true),
          //   DownloadPageButton(),
          const Gap(height: 20),
          if (!good)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_sharp,
                  color: Colors.green,
                ),
                Text(
                  better,
                  style: TextStyles.carioStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          const Gap(hRatio: 0.15),
        ],
      ),
    );
  }
}

// About Section

class MobileAboutSection extends ConsumerWidget {
  const MobileAboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider);
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AnimatedRowImages(),
        ),
        SliverList.builder(
          itemCount: aboutSections.length,
          itemBuilder: (context, index) {
            final AboutModel section = aboutSections[index];
            return Container(
              padding: padding(5.0),
              margin: padding(10.0),
              decoration: BoxDecoration(
                borderRadius: borderRadius(10.0),
                color: isDark ? Colors.white12 : Colors.black12,
                border: Border.all(color: SwitchColors.borderColor),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox.square(
                                dimension: 30,
                                child: SvgPicture.network(section.icon),
                              ),
                              const Gap(width: 10.0),
                              Text(
                                section.title,
                                style: TextStyles.cairoTitle(),
                              ),
                            ],
                          ),
                          const Gap(height: 10.0),
                          ProgressSection(
                            color: section.color,
                            rate: section.rate,
                            ratio: context.screenWidth * .4,
                          ),
                        ],
                      ),
                      Clicker(
                        onTap: () async {
                          await showImage(
                            context,
                            isDark ? section.darkImage : section.lightImage,
                          );
                        },
                        child: SizedBox(
                          height: context.screenHeight * .12,
                          width: context.screenWidth * .2,
                          child: Image.network(
                            isDark ? section.darkImage : section.lightImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (int i = 0; i < section.about.length; i++) ...{
                    Row(
                      children: [
                        const Icon(
                          Icons.done_outline_rounded,
                          color: Colors.green,
                        ),
                        const Gap(width: 5.0),
                        Expanded(
                          child: Text(
                            section.about[i],
                            style: TextStyles.carioStyle(),
                          ),
                        )
                      ],
                    )
                  }
                ],
              ),
            );
          },
        ),
        const SliverGap(hRatio: 0.13),
      ],
    );
  }
}

// Download Section

class MobileDowloadSection extends StatelessWidget {
  const MobileDowloadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Gap(height: 20.0),
          const AppInfo(isMobile: true),
          const Divider(),
          Padding(
            padding: padding(10.0),
            child: const QuestionsSection(isMobile: true),
          ),
          const Divider(),
          Padding(
            padding: padding(10.0),
            child: const SomeInstructions(),
          ),
          const Gap(hRatio: 0.13),
        ],
      ),
    );
  }
}

// Developer Section

class MobileDeveloper extends StatelessWidget {
  const MobileDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding(10.0),
      child: Column(
        children: <Widget>[
          Text(
            aboutDev,
            style: TextStyles.cairoTitle(),
          ),
          const Gap(height: 30.0),
          const Hadith(),
          const Divider(),
          Text(
            contactDev,
            style: TextStyles.cairoTitle(),
          ),
          const Gap(height: 30.0),
          const Report(isMobile: true),
          const Gap(height: 30.0),
          SizedBox(
            width: context.screenWidth * .8,
            child: const Divider(thickness: 1.2),
          ),
          const Gap(height: 10.0),
          const CopyRightsFooter(),
          const Gap(hRatio: 0.13),
        ],
      ),
    );
  }
}
