import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TabsManager extends Notifier<int> {
  @override
  int build() => 0;

  void navigateTo(int target) => state = target;
}

final tabsNavProvider = NotifierProvider<TabsManager, int>(TabsManager.new);

class OpenUrl {
  static Future<void> launchWebUrl({
     String? target,
    bool isEmail = false,
  }) async {
    try {
      if (isEmail) {
        final Uri emailUri = Uri(
          path: "mahmoudalshehyby@gmail.com",
          scheme: "mailto",
        );

        final bool canLaunchEmail = await launchUrl(emailUri);

        if (!canLaunchEmail) {
          return;
        }

        await launchUrl(emailUri);

        return;
      }

      final Uri uri = Uri.parse(target!);

      final bool canlaunch = await canLaunchUrl(uri);

      if (!canlaunch) {
        log("Can not Launch the target !!");
        return;
      }

      await launchUrl(uri);
    } catch (error) {
      log("Error while launching the target a=> $error");
    }
  }
}
