import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/navigator_key.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/constants/texts.dart';
import 'package:knooz_docs_api/presentations/web_view/navigation_tabs/tabs_management.dart';

class DownloadModel {
  final String title;
  final String targetUrl;
  final bool recommended;
  final String vSize;
  final List<String> description;

  const DownloadModel({
    required this.description,
    this.recommended = false,
    required this.targetUrl,
    required this.title,
    required this.vSize,
  });
}

const String appVersion = "Knooz-v1.0.1";

const List<DownloadModel> downloadModels = [
  DownloadModel(
    description: [
      "الإصدار الموصى به لمعظم المستخدمين",
      "لأجهزة الأندرويد الحديثة (2017 فما فوق)",
      "يعمل على معظم الهواتف الذكية والأجهزة اللوحية الحديثة",
      "يوفر أفضل أداء واستهلاك للطاقة",
      "يدعم المعالجات ذات 64-بت",
    ],
    vSize: "51.8 MB",
    recommended: true,
    targetUrl:
        "https://github.com/Cisco0xf/knooz_documentation_api_assets/releases/download/Knooz/Knooz-v1.0.1-arm64-v8a.apk",
    title: "$appVersion-arm64-v8a.apk",
  ),
  DownloadModel(
    description: [
      "مخصص لأجهزة الكروم بوك والأجهزة اللوحية",
      "يعمل على المعالجات من نوع Intel و AMD",
      "مثالي للأجهزة التي تعمل بمعالجات x86_64",
    ],
    targetUrl:
        "https://github.com/Cisco0xf/knooz_documentation_api_assets/releases/download/Islamic/Knooz-v1.0.1-x86_64.apk",
    title: "$appVersion-x86_64.apk",
    vSize: "54.9 MB",
  ),
  DownloadModel(
    description: [
      "للأجهزة القديمة والمتوسطة المواصفات",
      "يدعم الهواتف والأجهزة اللوحية من 2011 إلى 2017",
      "حل بديل إذا لم يعمل الإصدار 64-بت",
      "حجم أصغر مع توافقية أوسع",
    ],
    targetUrl:
        "https://github.com/Cisco0xf/knooz_documentation_api_assets/releases/download/Knooz/Knooz-v1.0.1-arm64-v8a.apk",
    title: "$appVersion-armeabi-v7a.apk",
    vSize: "48.7 MB",
  ),
];

Future<void> showDownloadDialog() async {
  final BuildContext context = navigatorKey.currentContext as BuildContext;
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: context.isMobile
            ? const EdgeInsets.symmetric(horizontal: 10.0)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius(10.0),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.isDesktop || context.isTablet
                ? context.screenWidth * .6
                : double.infinity,
          ),
          child: const DownloadDialog(),
        ),
      );
    },
  );
}

class DownloadDialog extends StatelessWidget {
  const DownloadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isMobile ? context.screenHeight * .8 : null,
      child: SingleChildScrollView(
        padding: padding(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: SwitchColors.borderColor),
                      color: SwitchColors.backgroundColor,
                      borderRadius: borderRadius(10.0)),
                  child: Clicker(
                    innerPadding: 10.0,
                    radius: 10.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
              ],
            ),
            const Gap(height: 20.0),
            Column(
              children: List<Widget>.generate(
                downloadModels.length,
                (index) {
                  return DownloadVersion(
                    version: downloadModels[index],
                    index: index,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DownloadVersion extends StatelessWidget {
  const DownloadVersion(
      {super.key, required this.version, required this.index});

  final DownloadModel version;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0) const Divider(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: padding(10.0),
                  decoration: BoxDecoration(
                    color: SwitchColors.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(FontAwesomeIcons.download),
                ),
                const Gap(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:
                          context.isMobile ? context.screenWidth * 0.44 : null,
                      child: Text(
                        version.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(height: 6.0),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: borderRadius(20.0),
                            border: Border.all(color: Colors.teal),
                          ),
                          padding: padding(7.0),
                          child: Text(
                            version.vSize,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (version.recommended) ...{
                          const Gap(width: 10.0),
                          Container(
                            padding: padding(6.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: borderRadius(20.0),
                            ),
                            child: const Text(
                              "RECOMMENDED",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        }
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            OutlinedButtonTheme(
              data: OutlinedButtonThemeData(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: borderRadius(30.0),
                      side: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
              ),
              child: OutlinedButton(
                onPressed: () async {
                  await OpenUrl.launchWebUrl(target: version.targetUrl)
                      .whenComplete(
                    () {
                      showToastification(
                        msg: startDownload,
                        title: downloading,
                        duration: 3000,
                      );
                    },
                  );
                  Navigator.of(navigatorKey.currentContext!).pop();
                },
                child: Row(
                  children: [
                    Text(
                      downloadVersion,
                      style: TextStyles.carioStyle(),
                    ),
                    const Gap(width: 7.0),
                    const Icon(Icons.download),
                  ],
                ),
              ),
            ),
          ],
        ),
        Gap(height: context.isMobile ? 10 : 20),
        for (int i = 0; i < version.description.length; i++) ...{
          Row(
            children: [
              const Icon(
                Icons.done_outline_rounded,
                color: Colors.green,
              ),
              const Gap(width: 10.0),
              Expanded(
                child: Text(
                  version.description[i],
                  style: TextStyles.carioStyle(),
                ),
              ),
            ],
          )
        }
      ],
    );
  }
}
