import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/commons/sizes.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/presentations/web_view/sections/about_section/about_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

class AboutSections extends StatelessWidget {
  const AboutSections({super.key});

  @override
  Widget build(BuildContext context) {
    return /* CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const Gap(height: 30.0),
              const AnimatedRowImages(),
            ],
          ),
        ),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: aboutSections.length,
          itemBuilder: (context, index) {
            return SectionItem(
              aboutModel: aboutSections[index],
            );
          },
        ),
      ],
    ) */
        Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Gap(height: 30.0),
            const AnimatedRowImages(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SectionItem(aboutModel: aboutSections[0]),
                SectionItem(aboutModel: aboutSections[1]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SectionItem(aboutModel: aboutSections[2]),
                SectionItem(aboutModel: aboutSections[3]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SectionItem(aboutModel: aboutSections[4]),
                SectionItem(aboutModel: aboutSections[5]),
              ],
            ),
            /* GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: context.screenHeight * .4,
              ),
              itemCount: aboutSections.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SectionItem(
                  aboutModel: aboutSections[index],
                );
              },
            ), */
            const Gap(hRatio: 0.1),
          ],
        ),
      ),
    );
  }
}

class AnimatedRowImages extends StatefulWidget {
  const AnimatedRowImages({super.key});

  @override
  State<AnimatedRowImages> createState() => _AnimatedRowImagesState();
}

class _AnimatedRowImagesState extends State<AnimatedRowImages>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = Tween<double>(begin: 0.95, end: 1.0).animate(_controller);

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List<Widget>.generate(
          aboutSections.length,
          (index) {
            return ScaleTransition(
              scale: _animation,
              child: SizedBox(
                // color: Colors.amber,
                height: WidgetsSize.animtedImageSize(context).$2,
                width: WidgetsSize.animtedImageSize(context).$1,
                child: Consumer(
                  builder: (_, ref, __) {
                    return Image.network(
                      ref.watch(themeProvider)
                          ? aboutSections[index].darkImage
                          : aboutSections[index].lightImage,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SectionItem extends ConsumerWidget {
  const SectionItem({
    super.key,
    required this.aboutModel,
  });

  final AboutModel aboutModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider);
    return Container(
      padding: padding(10.0),
      margin: padding(10.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius(10.0),
        color: isDark ? Colors.white12 : Colors.black12,
        border: Border.all(color: SwitchColors.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            // color: Colors.green,
            width: context.screenWidth * .29,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox.square(
                      dimension: 30,
                      child: SvgPicture.network(aboutModel.icon),
                    ),
                    const Gap(width: 10.0),
                    Text(
                      aboutModel.title,
                      style: TextStyles.cairoTitle(),
                    ),
                  ],
                ),
                const Gap(height: 10.0),
                ProgressSection(
                  color: aboutModel.color,
                  rate: aboutModel.rate,
                ),
                const Gap(height: 10.0),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(
                    aboutModel.about.length,
                    (index) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.done_outline_rounded,
                            color: Colors.green,
                          ),
                          const Gap(width: 10.0),
                          Expanded(
                            child: Text(
                              aboutModel.about[index],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.carioStyle(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          ScaleImage(
            image: isDark ? aboutModel.darkImage : aboutModel.lightImage,
          ),
        ],
      ),
    );
  }
}

class ProgressSection extends StatelessWidget {
  const ProgressSection({
    super.key,
    required this.color,
    required this.rate,
    this.ratio,
  });

  final double rate;
  final Color color;
  final double? ratio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ratio ?? context.screenWidth * .1,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: rate),
        duration: const Duration(milliseconds: 1200),
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            borderRadius: borderRadius(10.0),
            valueColor: AlwaysStoppedAnimation(
              color,
            ),
          );
        },
      ),
    );
  }
}

class ScaleImage extends StatefulWidget {
  const ScaleImage({super.key, required this.image});
  final String image;

  @override
  State<ScaleImage> createState() => _ScaleImageState();
}

class _ScaleImageState extends State<ScaleImage> {
  bool scale = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          scale = true;
        });
      },
      onExit: (_) {
        setState(() {
          scale = false;
        });
      },
      child: Clicker(
        onTap: () async {
          await showImage(context, widget.image);
        },
        child: Transform.scale(
          scale: scale ? 1.1 : 1.0,
          child: SizedBox(
            height: context.screenHeight * .37,
            width: context.screenWidth * .13,
            child: Image.network(widget.image),
          ),
        ),
      ),
    );
  }
}

Future<void> showImage(BuildContext context, String image) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: InteractiveViewer(child: Image.network(image)),
      );
    },
  );
}
