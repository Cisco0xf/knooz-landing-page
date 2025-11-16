import 'package:flutter/material.dart';
import 'package:knooz_docs_api/commons/commons.dart';
import 'package:knooz_docs_api/commons/gaps.dart';
import 'package:knooz_docs_api/commons/navigator_key.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';
import 'package:knooz_docs_api/constants/colors.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:knooz_docs_api/constants/texts.dart';

Future<void> showMoreDialog() async {
  final BuildContext context = navigatorKey.currentContext as BuildContext;

  await showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Dialog(
              insetPadding: context.isMobile
                  ? const EdgeInsets.symmetric(horizontal: 0.0)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius(10.0),
              ),
              child: const MoreInfoDialog(),
            ),
          ),
        ),
      );
    },
  );
}

class MoreInfoDialog extends StatelessWidget {
  const MoreInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: SwitchColors.backgroundColor,
                  borderRadius: borderRadius(7.0),
                  border: Border.all(color: SwitchColors.borderColor),
                ),
                child: Clicker(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          const Gap(height: 20.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.admin_panel_settings),
              const Gap(width: 10.0),
              Text(permissions, style: TextStyles.carioStyle(fontWeight: true)),
            ],
          ),
          const Gap(height: 10.0),
          Text(
            appCanGet,
            style: TextStyles.carioStyle(color: Colors.grey),
          ),
          const Gap(height: 20.0),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PermissionItem(
                  icon: Icons.location_on,
                  subTitle: locationSubText,
                  title: locationPremission),
              PermissionItem(
                  icon: Icons.vibration,
                  subTitle: vibrationSubText,
                  title: vibration),
            ],
          ),
          const Gap(height: 25.0),
          const PermissionItem(
              icon: Icons.network_wifi,
              subTitle: internetSubText,
              title: internet),
          SizedBox(width: context.screenWidth * .2, child: const Divider()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.admin_panel_settings),
              const Gap(width: 10.0),
              Text(
                moreInfo,
                style: TextStyles.carioStyle(fontWeight: true),
              ),
            ],
          ),
          const Gap(height: 20.0),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PermissionItem(
                icon: Icons.android,
                title: needAnd,
                subTitle: needAndSubTitle,
              ),
              PermissionItem(
                icon: Icons.verified_user_outlined,
                title: version,
                subTitle: versionSubTitle,
              ),
            ],
          ),
          const Gap(height: 20.0),
          const PermissionItem(
            icon: Icons.date_range,
            title: updateDate,
            subTitle: updatedateSub,
          ),
        ],
      ),
    );
  }
}

class PermissionItem extends StatelessWidget {
  const PermissionItem({
    super.key,
    this.subTitle,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const Gap(width: 10.0),
          SizedBox(
            width: context.isMobile
                ? context.screenWidth * .3
                : context.screenWidth * .16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.carioStyle(fontWeight: true),
                ),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: TextStyles.carioStyle(
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
