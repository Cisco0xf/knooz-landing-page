import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/enums.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_management.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_model.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';

class NavigationTabs extends ConsumerWidget {
  const NavigationTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentTab = ref.watch(tabsNavProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        mainTabs.length,
        (index) {
          return TabItem(
            isSelected: currentTab == index,
            tab: mainTabs[index],
            onTap: () {
              ref.read(tabsNavProvider.notifier).navigateTo(index);
            },
          );
        },
      ),
    );
  }
}

class TabItem extends ConsumerStatefulWidget {
  const TabItem({
    super.key,
    required this.isSelected,
    required this.tab,
    required this.onTap,
  });

  final TabsModel tab;
  final bool isSelected;
  final void Function() onTap;

  @override
  ConsumerState<TabItem> createState() => _TabItemState();
}

class _TabItemState extends ConsumerState<TabItem> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    ref.watch(themeProvider);
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _scale = 1.1;
        });
      },
      onExit: (event) {
        setState(() {
          _scale = 1.0;
        });
      },
      child: Column(
        children: [
          Transform.scale(
            scale: _scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: padding(10.0, from: From.horizontal),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.isSelected
                      ? SwitchColors.secondaryColor
                      : SwitchColors.borderColor,
                ),
                borderRadius: borderRadius(10),
              ),
              child: Clicker(
                onTap: widget.onTap,
                innerPadding: 7.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      widget.tab.icons,
                      size: 20.0,
                      color: widget.isSelected ? Colors.teal : null,
                    ),
                    const Gap(width: 10),
                    Text(
                      widget.tab.title,
                      textAlign: TextAlign.center,
                      style: TextStyles.carioStyle(
                          fontSize: 14,
                          color: widget.isSelected ? Colors.teal : null),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(hRatio: 0.01),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: widget.isSelected
                ? Container(
                    width: 35.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius(5.0),
                      color: Colors.teal,
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
