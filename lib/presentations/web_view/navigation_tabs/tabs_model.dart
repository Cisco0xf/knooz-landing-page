import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:knooz_docs_api/presentations/mobile_view/mobile_view.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/about_section/about_sections.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/dev_section/developer_section.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/download_section/download_section.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/home_section/home_section.dart';

class TabsModel {
  final String title;
  final IconData icons;
  final Widget navigation;
  final Widget mobileNav;

  const TabsModel({
    required this.icons,
    required this.navigation,
    required this.title,
    required this.mobileNav,
  });
}

const List<TabsModel> mainTabs = [
  TabsModel(
    icons: Icons.home,
    mobileNav: MobileHomsScreen(),
    navigation: HomeSection(),
    title: "الرئيسية",
  ),
  TabsModel(
    icons: FontAwesomeIcons.mobileScreen,
    mobileNav: MobileAboutSection(),
    navigation: AboutSections(),
    title: "الأقسام",
  ),
  TabsModel(
    icons: FontAwesomeIcons.download,
    mobileNav: MobileDowloadSection(),
    navigation: DownloadSection(),
    title: "التحميل",
  ),
  TabsModel(
    icons: Icons.person,
    mobileNav: MobileDeveloper(),
    navigation: DeveloperSection(),
    title: "المطور",
  ),
];
