import 'package:flutter/material.dart';
import 'package:knooz_docs_api/commons/sizes.dart';
import 'package:knooz_docs_api/constants/enums.dart';
import 'package:knooz_docs_api/constants/text_styles.dart';
import 'package:toastification/toastification.dart';

// Padding and margin

EdgeInsetsGeometry padding(
  double value, {
  From from = From.both,
}) {
  if (from == From.both) {
    return EdgeInsets.symmetric(horizontal: value, vertical: value);
  }
  if (from == From.horizontal) {
    return EdgeInsets.symmetric(horizontal: value);
  }

  return EdgeInsets.symmetric(vertical: value);
}

///
BorderRadius borderRadius(double value, {Side from = Side.all}) {
  if (from == Side.all) {
    return BorderRadius.circular(value);
  }

  if (from == Side.fromBottom) {
    return BorderRadius.only(
      topLeft: Radius.circular(value),
      topRight: Radius.circular(value),
    );
  }

  return BorderRadius.vertical(
    bottom: Radius.circular(value),
  );
}

// CustomClicker

class Clicker extends StatelessWidget {
  const Clicker({
    super.key,
    required this.onTap,
    this.radius = 10.0,
    required this.child,
    this.isCircular = false,
    this.innerPadding = 10.0,
    this.hoverColor = Colors.transparent,
  });

  final Widget child;
  final double radius;
  final double innerPadding;
  final Color hoverColor;
  final bool isCircular;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: isCircular ? null : borderRadius(radius),
        customBorder: isCircular ? const CircleBorder() : null,
        child: Padding(
          padding: padding(innerPadding),
          child: child,
        ),
      ),
    );
  }
}

//

class MockupImage extends StatelessWidget {
  const MockupImage({
    super.key,
    this.height,
    this.width,
    required this.target,
  });

  final double? height;
  final double? width;

  final String target;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WidgetsSize.mainMockupSize(context).$2,
      width: WidgetsSize.mainMockupSize(context).$1,
      child: Image.network(target),
    );
  }
}

void showToastification({required String msg, required String title, int duration = 2000}) {
  toastification.show(
    type: ToastificationType.success,
    padding: padding(6.0),
    margin: padding(7.0),
    direction: TextDirection.rtl,
    applyBlurEffect: true,
    title: Text(
      title,
      style: TextStyles.carioStyle(fontSize: 16.0, fontWeight: true),
    ),
    showProgressBar: false,
    animationDuration: const Duration(milliseconds: 300),
    autoCloseDuration: Duration(milliseconds: duration),
    description: Text(msg, style: TextStyles.carioStyle()),
  );
}
