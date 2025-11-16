import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/constants/assets.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/constants/texts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_management.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

class HomeSection extends ConsumerWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider);
    return Column(
      children: [
        const Gap(hRatio: 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox.square(
                  dimension: context.screenWidth * .15,
                  child: Image.network(AppImage.appLogoPng),
                ),
                const GreetingIcon(),
                const Gap(height: 20),
                SizedBox(
                    width: context.screenWidth * .4,
                    child: const WelcomeTyper()),
                const Gap(height: 20),
                const AnimatedMainText(),
                const Gap(hRatio: 0.04),
                const DownloadPageButton(),
                const SizedBox(height: 20),
              ],
            ),
            AnimatedMockupImages(isDark: isDark)
          ],
        ),
      ],
    );
  }
}

class WelcomeTyper extends ConsumerWidget {
  const WelcomeTyper({super.key, this.fontSize = 18, this.fontWeight = true});
  final bool fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return DefaultTextStyle(
      style: TextStyles.carioStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: SwitchColors.textColor,
      ),
      child: AnimatedTextKit(
        repeatForever: false,
        totalRepeatCount: 1,
        animatedTexts: [
          TyperAnimatedText(welcomeSubText),
        ],
      ),
    );
  }
}

class AnimatedMockupImages extends StatefulWidget {
  const AnimatedMockupImages({
    super.key,
    required this.isDark,
  });
  final bool isDark;

  @override
  State<AnimatedMockupImages> createState() => AnimatedMockupImagesState();
}

class AnimatedMockupImagesState extends State<AnimatedMockupImages>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    _animation = Tween<double>(begin: 0.96, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MockupImage(
            target: widget.isDark ? AppImage.darkHome : AppImage.lightHome,
          ),
          MockupImage(
            target: widget.isDark ? AppImage.darkQuran : AppImage.lightQuran,
          ),
        ],
      ),
    );
  }
}

class AnimatedMainText extends ConsumerStatefulWidget {
  const AnimatedMainText({super.key, this.isMobile = false});
  final bool isMobile;

  @override
  ConsumerState<AnimatedMainText> createState() => _AnimatedMainTextState();
}

class _AnimatedMainTextState extends ConsumerState<AnimatedMainText> {
  bool isWieght = false;
  @override
  Widget build(BuildContext context) {
    final bool isDark = ref.watch(themeProvider);
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isWieght = true;
        });
      },
      onExit: (_) {
        setState(() {
          isWieght = false;
        });
      },
      child: Container(
        padding: padding(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: !isWieght ? Colors.transparent : SwitchColors.borderColor,
            width: isWieght ? 2.0 : 1.0,
          ),
          borderRadius: borderRadius(10.0),
          color: isDark ? Colors.white12 : Colors.black12,
        ),
        width: widget.isMobile ? null : context.screenWidth * .4,
        child: Text(
          mainText,
          style: TextStyles.carioStyle(
            fontSize: 18,
            color: SwitchColors.textColor,
          ),
        ),
      ),
    );
  }
}

class GreetingIcon extends ConsumerWidget {
  const GreetingIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return MouseRegion(
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.handshakeAngle),
          const Gap(width: 10),
          Text(
            welcomeText,
            style: TextStyles.cairoTitle(),
          ),
        ],
      ),
    );
  }
}

class DownloadPageButton extends ConsumerStatefulWidget {
  const DownloadPageButton({super.key});

  @override
  ConsumerState<DownloadPageButton> createState() => _DownloadPageButtonState();
}

class _DownloadPageButtonState extends ConsumerState<DownloadPageButton> {
  bool showButton = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MouseRegion(
          onEnter: (event) {
            setState(() {
              showButton = true;
            });
          },
          onExit: (event) {
            setState(() {
              showButton = false;
            });
          },
          child: SizedBox(
            width: 200 /* context.screenWidth * .17 */,
            height: context.screenHeight * .07,
            child: OutlinedButtonTheme(
              data: OutlinedButtonThemeData(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: borderRadius(35.0),
                      side: BorderSide(
                        color: showButton
                            ? Colors.green
                            : SwitchColors.borderColor,
                        width: showButton ? 2.3 : 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              child: OutlinedButton(
                onPressed: () {
                  ref.read(tabsNavProvider.notifier).navigateTo(2);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: !showButton
                          ? const Icon(
                              FontAwesomeIcons.download,
                              key: ValueKey(handShakeIcon),
                            )
                          : const Icon(
                              Icons.keyboard_double_arrow_left_rounded,
                              key: ValueKey(nonHandShakeIcon),
                            ),
                    ),
                    const Gap(width: 10.0),
                    Text(
                      downloadPage,
                      style: TextStyles.carioStyle(
                        fontWeight: showButton,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
