import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';
import 'package:morph_switch/morph_switch.dart';

class ModeSwitcher extends ConsumerWidget {
  const ModeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MorphSwitch(
          stateValue: isDark,
          onSwitch: (mode) {
            ref.read(themeProvider.notifier).switchTheme(mode);
          },
          thumbOnBgColor: const Color(0xFF050d11),
          switcherRadius: const SwitcherRadius.all(radius: 30),
          onBgColor: const Color(0xFF3f614c),
          onBgIcon: Icons.ac_unit_rounded,
          offBgColor: Colors.teal[200],
          thumbOffBgColor: Colors.blueGrey,
          borderColor: SwitchColors.borderColor,
          thumbOffIcon: Icons.light_mode_rounded,
          thumbOnIcon: Icons.dark_mode_rounded,
        ),
        const Gap(wRatio: 0.01),
      ],
    );
  }
}
