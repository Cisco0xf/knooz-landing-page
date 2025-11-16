import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knooz_docs_api/commons/navigator_key.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/presentations/main_layout.dart';
import 'package:knooz_docs_api/statemanagement/theme_switcher.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(
    const ProviderScope(
      child: KnoozDocAPI(),
    ),
  );
}

class KnoozDocAPI extends ConsumerWidget {
  const KnoozDocAPI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return ToastificationWrapper(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: const ResponsiveLayout(),
        supportedLocales: const <Locale>[
          Locale("en"),
          Locale("ar"),
        ],
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale("ar"),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: SwitchColors.backgroundColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: SwitchColors.primaryColor,
            brightness: ref.read(themeProvider.notifier).appBrightness,
          ),
        ),
      ),
    );
  }
}

/* 
1- All the images will nbe hosted in the GitHub

2- I will let the very small images in the locale assets

3- The fonts will be provided from the Google Fonts package

4- Theme Will be very simple 3 or 4 colors for maximum

5- There will be Light / Dark theme 




 */


/* 
# ADB With tablet

1- Enable the developer options in the Tablet

2- Enable the USB debugging

3- Connect the Tablet with PC with the USB cable

4- Open the ADB tools on my pc

5- Make sure there is no another connected devices to the pc

5- run `adb devices`

6- Get the name of the device

7- Run command ⇒ adb -s <DEVICE_NAME> tcpip 5555

8- Run adb connect 192.168.8.105

 */
