import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/commons/sizes.dart';
import 'package:knooz_docs_api/constants/assets.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/enums.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/constants/texts.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_management.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/download_section/download_dialog.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/download_section/more_info_dialog.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

class DownloadSection extends ConsumerWidget {
  const DownloadSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return const Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gap(height: 30),
            AppInfo(),
            Gap(height: 30),
            CommonQuestions(),
            Gap(hRatio: 0.1),
          ],
        ),
      ),
    );
  }
}

class AppInfo extends StatelessWidget {
  const AppInfo({super.key, this.isMobile = false});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(isMobile ? 10.0 : 30.0, from: From.horizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (isMobile)
                SizedBox(
                  height: context.screenHeight * .1,
                  width: context.screenWidth * .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("تطبيق $appName: $titleSuffext",
                              style: TextStyles.carioStyle(fontWeight: true)),
                          isMobile
                              ? const Gap(height: 10.0)
                              : const Gap(hRatio: 0.03),
                          Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                color: Colors.green,
                              ),
                              const Gap(width: 5.0),
                              Text(
                                appFree,
                                style: TextStyles.carioStyle(
                                  color: Colors.green,
                                  fontSize: isMobile ? 10 : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      //const Gap(width: 30),
                      const ScaleAppIcon(isMobile: true)
                    ],
                  ),
                )
              else ...{
                Text(
                  "تطبيق $appName: $titleSuffext",
                  style: isMobile
                      ? TextStyles.carioStyle(fontWeight: true)
                      : TextStyles.cairoTitle(),
                ),
                isMobile ? const Gap(height: 10.0) : const Gap(hRatio: 0.03),
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Colors.green,
                    ),
                    const Gap(width: 5.0),
                    Text(
                      appFree,
                      style: TextStyles.carioStyle(
                        color: Colors.green,
                        fontSize: isMobile ? 10 : null,
                      ),
                    ),
                  ],
                ),
              },
              Gap(height: isMobile ? 5.0 : 10.0),
              Row(
                children: [
                  Icon(
                    Icons.file_download_outlined,
                    color: SwitchColors.accentColor,
                  ),
                  const Gap(width: 5.0),
                  Text.rich(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.end,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: appSizeInfo,
                          style: TextStyles.carioStyle(
                            color: SwitchColors.accentColor,
                            fontWeight: true,
                          ),
                        ),
                        const TextSpan(text: " : "),
                        TextSpan(
                          text: appSizeLabel,
                          style: TextStyles.carioStyle(
                            color: SwitchColors.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20, child: VerticalDivider()),
                  Clicker(
                    onTap: () async {
                      await showMoreDialog();
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.info,
                          size: 20.0,
                          color: Colors.blue,
                        ),
                        const Gap(width: 5.0),
                        Text(
                          moreInfo,
                          style: TextStyles.carioStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Gap(hRatio: 0.03),
              Row(
                children: [
                  DownloadButton(
                    isMobile: isMobile,
                  ),
                  const Gap(wRatio: 0.03),
                  const ShareButton()
                ],
              )
            ],
          ),
          if (!isMobile) const ScaleAppIcon(),
        ],
      ),
    );
  }
}

class ScaleAppIcon extends StatefulWidget {
  const ScaleAppIcon({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  State<ScaleAppIcon> createState() => _ScaleAppIconState();
}

class _ScaleAppIconState extends State<ScaleAppIcon> {
  bool scale = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => scale = true);
      },
      onExit: (_) {
        setState(() => scale = false);
      },
      child: Transform.scale(
        scale: scale ? 1.1 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            border: Border.all(
              color: scale ? Colors.white : Colors.transparent,
            ),
            borderRadius: borderRadius(10.0),
          ),
          child: SizedBox.square(
            dimension: widget.isMobile
                ? context.screenHeight * .09
                : context.screenWidth * .1,
            child: ClipRRect(
              borderRadius: borderRadius(10.0),
              child: Image.network(AppImage.knoozLogoPng),
            ),
          ),
        ),
      ),
    );
  }
}

class DownloadButton extends ConsumerStatefulWidget {
  const DownloadButton({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  ConsumerState<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends ConsumerState<DownloadButton> {
  bool showDownload = false;
  @override
  Widget build(BuildContext context) {
    ref.watch(themeProvider);
    return MouseRegion(
      onEnter: (_) {
        setState(() => showDownload = true);
      },
      onExit: (_) {
        setState(() => showDownload = false);
      },
      child: SizedBox(
        width: widget.isMobile ? context.screenWidth * .44 : 200,
        height: context.screenHeight * .07,
        child: MaterialButton(
          onPressed: () async {
            // await OpenUrl.launchWebUrl(target: downloadUrl);
           await showDownloadDialog();
          }, // DOWNLOAD
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius(showDownload ? 30.0 : 10.0),
          ),
          color: SwitchColors.secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: showDownload
                    ? const Icon(
                        FontAwesomeIcons.download,
                        key: ValueKey("DOWNLOAD_ICON_ON"),
                      )
                    : const Icon(
                        Icons.download,
                        key: ValueKey("DOWNLOAD_ICON_OFF"),
                      ),
              ),
              const Gap(width: 10.0),
              Text(
                downloadApp,
                style: TextStyles.carioStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          await FlutterClipboard.copy(shareText);
          log("Site has been copied successfully");
          showToastification(msg: copiedLable, title: cpoied);
        } catch (error) {
          log("Error while Shareing the app => $error");
        }
      },
      child: Row(
        children: <Widget>[
          const Icon(Icons.share),
          const Gap(width: 10),
          Text(share, style: TextStyles.carioStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Title With Icon

class TitleWithIcon extends ConsumerWidget {
  const TitleWithIcon({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return Row(
      children: <Widget>[
        Container(
          padding: padding(6.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: SwitchColors.borderColor, width: 2.0),
          ),
          child: Icon(
            icon,
            color: SwitchColors.accentColor,
          ),
        ),
        const Gap(width: 20),
        Text(
          title,
          style: TextStyles.carioStyle(
            fontWeight: true,
            fontSize: 20,
            color: SwitchColors.accentColor,
          ),
        ),
      ],
    );
  }
}

// CommonQuestion

class CommonQuestions extends StatelessWidget {
  const CommonQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(20.0, from: From.horizontal),
      child: const Row(
        children: <Widget>[
          QuestionsSection(),
          Expanded(child: SizedBox()),
          SomeInstructions()
        ],
      ),
    );
  }
}

class QuestionsSection extends StatelessWidget {
  const QuestionsSection({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TitleWithIcon(
          title: commonQ,
          icon: FontAwesomeIcons.question,
        ),
        Gap(height: isMobile ? 10.0 : 30),
        const QuesAndAns(a: a1, q: q1),
        SizedBox(
          width: isMobile ? context.screenWidth * .7 : context.screenWidth * .4,
          child: const Divider(),
        ),
        const QuesAndAns(a: a2, q: q2),
      ],
    );
  }
}

class QuesAndAns extends StatelessWidget {
  const QuesAndAns({
    super.key,
    required this.a,
    required this.q,
  });
  final String q;
  final List<String> a;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          q,
          style: TextStyles.carioStyle(fontWeight: true),
        ),
        const Gap(height: 10.0),
        for (int i = 0; i < a.length; i++) ...{
          SizedBox(
            width: WidgetsSize.downloadSectionWidth(context),
            child: Text(
              i != a.length - 1 ? "${a[i]}\n" : a[i],
              style: TextStyles.carioStyle(),
            ),
          ),
        }
      ],
    );
  }
}

// About tht app

class SomeInstructions extends StatelessWidget {
  const SomeInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const TitleWithIcon(
          title: notesAboutApp,
          icon: FontAwesomeIcons.info,
        ),
        const Gap(height: 30.0),
        for (int i = 0; i < notesApp.length; i++) ...{
          SizedBox(
            width: WidgetsSize.downloadSectionWidth(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info),
                const Gap(width: 5.0),
                Expanded(
                  child: Text(
                    notesApp[i],
                    style: TextStyles.carioStyle(),
                  ),
                ),
              ],
            ),
          ),
          if (i != notesApp.length - 1)
            Container(
              padding: padding(5.0, from: From.vertical),
              width: WidgetsSize.downloadSectionWidth(context),
              child: const Divider(),
            ),
        }
      ],
    );
  }
}
