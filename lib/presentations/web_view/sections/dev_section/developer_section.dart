import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/enums.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/constants/texts.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_management.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

const List<String> aboutDevTexts = <String>[
  "قمت ببناء هذا التطبيق بنيه خالصة لوجه الله تعالى.\n",
  "فما كان فيه من صواب فمن توفيق الله وحده، وما كان فيه من خطأ أو نسيان أو تقصير فمني ومن الشيطان، والله ورسوله منه براء.\n",
  "سائلاً المولى عز وجل أن يغفر لي زللي، ويتجاوز عن تقصير ويقبل عملي بأحسن ما يقبل به أعمال عباده\n",
  "إن استفدت من التطبيق، فلا تنساني من صالح دعائك لي و لوالديّ ",
];

class DeveloperData {
  final String targetUrl;
  final String label;
  final Color color;
  final IconData icon;

  const DeveloperData({
    required this.color,
    required this.icon,
    required this.label,
    required this.targetUrl,
  });
}

/* 

 */

// github, linkedIn, gmail, whatsApp, Stackoverflow,
const List<DeveloperData> devData = [
  DeveloperData(
    color: Colors.black,
    icon: FontAwesomeIcons.github,
    label: "GitHub",
    targetUrl: "https://github.com/Cisco0xf",
  ),
  DeveloperData(
    color: Colors.blue,
    icon: FontAwesomeIcons.linkedinIn,
    label: "LinkedIn",
    targetUrl: "http://www.linkedin.com/in/mahmoud-al-shehyby",
  ),
  DeveloperData(
    color: Colors.green,
    icon: FontAwesomeIcons.whatsapp,
    label: "WhatsApp",
    targetUrl: "http://wa.me/+201207269113",
  ),
 
  DeveloperData(
    color: Colors.amber,
    icon: FontAwesomeIcons.stackOverflow,
    label: "StackOverflow",
    targetUrl: "https://stackoverflow.com/users/23598383/mahmoud-al-shehyby",
  ),
];

class DeveloperSection extends StatelessWidget {
  const DeveloperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: padding(
          context.screenWidth < 800 ? 0.0 : 50,
          from: From.horizontal,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: context.screenWidth * .37,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        aboutDev,
                        style: TextStyles.cairoTitle(),
                      ),
                      const Gap(height: 30.0),
                      const Hadith(),
                    ],
                  ),
                ),
                SizedBox(
                  width: context.screenWidth * .37,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contactDev,
                        style: TextStyles.cairoTitle(),
                      ),
                      const Gap(height: 30.0),
                      const Report(),
                    ],
                  ),
                ),
              ],
            ),
            //  const Expanded(child: SizedBox.shrink()),
            SizedBox(
              width: context.screenWidth * .5,
              child: const Divider(thickness: 2.0, height: 50.0),
            ),

            const CopyRightsFooter(),

            const Gap(hRatio: 0.12),
          ],
        ),
      ),
    );
  }
}

class Hadith extends ConsumerStatefulWidget {
  const Hadith({super.key});

  @override
  ConsumerState<Hadith> createState() => _HadithState();
}

class _HadithState extends ConsumerState<Hadith> {
  bool animateHadith = false;

  final List<Shadow> _shadows = List<Shadow>.generate(
    4,
    (index) {
      return Shadow(
        color: Colors.green,
        blurRadius: index * 3,
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onExit: (_) {
            setState(() => animateHadith = false);
          },
          onEnter: (_) {
            setState(() => animateHadith = true);
          },
          child: Container(
            padding: padding(20.0),
            decoration: BoxDecoration(
              borderRadius: borderRadius(animateHadith ? 20.0 : 10.0),
              border: Border.all(
                color: animateHadith ? Colors.white54 : Colors.white30,
                width: 1.0,
              ),
              color: Colors.black12,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  hadith,
                  style: TextStyles.carioStyle(
                      fontSize: 20, shadows: animateHadith ? _shadows : null),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      rawy,
                      style: TextStyles.carioStyle(
                          fontSize: 17,
                          shadows: animateHadith ? _shadows : null),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const Gap(height: 30.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            aboutDevTexts.length,
            (index) {
              return CoolText(label: aboutDevTexts[index]);
            },
          ),
        ),
      ],
    );
  }
}

//

class Report extends ConsumerWidget {
  const Report({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          issues,
          style: TextStyles.carioStyle(fontSize: 17),
        ),
        Gap(height: isMobile ? 10.0 : 30.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius(10.0),
            color: isDark ? Colors.black26 : Colors.white30,
            border: Border.all(color: SwitchColors.borderColor),
          ),
          child: Clicker(
            onTap: () async {
              await OpenUrl.launchWebUrl(
                target: "https://forms.gle/anGj3st8UGWcqCUZA",
              );
            },
            innerPadding: 10.0,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: padding(13.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 2.0),
                  ),
                  child: const Icon(Icons.flag),
                ),
                const Gap(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      reportIssue,
                      style: TextStyles.carioStyle(),
                    ),
                    Text(
                      helpUs,
                      style: TextStyles.carioStyle(),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox.shrink()),
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        ),
        const Gap(height: 30.0),
        Text(
          orYouCan,
          style: isMobile
              ? TextStyles.carioStyle(fontSize: 19, fontWeight: true)
              : TextStyles.cairoTitle(),
        ),
        const Gap(height: 10.0),
        Row(
          children: <Widget>[
            Clicker(
                onTap: () async {
                  await OpenUrl.launchWebUrl(isEmail: true);
                },
                child: const CoolText(label: email)),
            const Gap(width: 10.0),
            Container(
              padding: padding(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SwitchColors.borderColor,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
        const Gap(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(
            devData.length,
            (index) {
              return DevPlatform(
                devData: devData[index],
                isMobile: isMobile,
              );
            },
          ),
        ),
      ],
    );
  }
}

class CoolText extends StatefulWidget {
  const CoolText(
      {super.key,
      this.shadowColor = Colors.green,
      required this.label,
      this.fontSize = 17});

  final Color shadowColor;
  final String label;
  final double fontSize;

  @override
  State<CoolText> createState() => _CoolTextState();
}

class _CoolTextState extends State<CoolText> {
  bool isAnimated = false;

  List<Shadow> get _shadows => List<Shadow>.generate(
        4,
        (index) {
          return Shadow(
            color: widget.shadowColor,
            blurRadius: index * 3,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isAnimated = true);
      },
      onExit: (_) {
        setState(() => isAnimated = false);
      },
      child: Text(
        widget.label,
        style: TextStyles.carioStyle(
          fontSize: 17.0,
          shadows: isAnimated ? _shadows : null,
        ),
      ),
    );
  }
}

class DevPlatform extends StatefulWidget {
  const DevPlatform({
    super.key,
    required this.devData,
    required this.isMobile,
  });

  final DeveloperData devData;
  final bool isMobile;

  @override
  State<DevPlatform> createState() => _DevPlatformState();
}

class _DevPlatformState extends State<DevPlatform> {
  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => animate = true);
      },
      onExit: (_) {
        setState(() => animate = false);
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox.square(
          dimension: widget.isMobile
              ? context.screenHeight * .09
              : context.screenHeight * .11,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              borderRadius: borderRadius(animate ? 20.0 : 10.0),
              border: Border.all(
                color: animate
                    ? widget.devData.color.withOpacity(0.5)
                    : SwitchColors.borderColor,
              ),
              color: SwitchColors.backgroundColor,
              boxShadow: !animate
                  ? null
                  : [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: widget.devData.color.withOpacity(0.6),
                        offset: const Offset(-4, -4),
                        spreadRadius: -5.0,
                      ),
                      BoxShadow(
                        blurRadius: 5.0,
                        color: widget.devData.color.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        spreadRadius: 0.5,
                      ),
                    ],
            ),
            child: Clicker(
              radius: animate ? 20.0 : 10.0,
              onTap: () async {
                await OpenUrl.launchWebUrl(
                  target: widget.devData.targetUrl,
                  isEmail: widget.devData.targetUrl == "NULL",
                );
              },
              innerPadding: 7.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(widget.devData.icon),
                  const Gap(height: 7.0),
                  Text(
                    widget.devData.label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Copy Rights

class CopyRightsFooter extends StatefulWidget {
  const CopyRightsFooter({super.key});

  @override
  State<CopyRightsFooter> createState() => _CopyRightsFooterState();
}

class _CopyRightsFooterState extends State<CopyRightsFooter> {
  bool animate = false;

  List<Shadow>? copyRightShadow({Color color = Colors.green}) {
    if (animate) {
      return List.generate(
        4,
        (index) {
          return Shadow(
            color: color,
            blurRadius: index * 3,
          );
        },
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          animate = true;
        });
      },
      onExit: (_) {
        setState(() {
          animate = false;
        });
      },
      child: Transform.scale(
        scale: animate ? 1.1 : 1.0,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Text(
                copyRight,
                style: TextStyles.carioStyle(
                  color: Colors.grey,
                ),
              ),
              const Gap(height: 10.0),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: devWith,
                      style: TextStyles.carioStyle(
                        shadows: copyRightShadow(),
                      ),
                    ),
                    TextSpan(
                      text: "Flutter ",
                      style: TextStyles.carioStyle(
                        fontWeight: true,
                        color: Colors.blueAccent,
                        shadows: copyRightShadow(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: made,
                      style: TextStyles.carioStyle(
                        shadows: copyRightShadow(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
