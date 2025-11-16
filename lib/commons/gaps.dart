import 'package:flutter/material.dart';
import 'package:knooz_docs_api/commons/screen_dimentions.dart';

// Gap for Render Box

class Gap extends StatelessWidget {
  const Gap({super.key, this.hRatio, this.wRatio, this.width = 0.0, this.height = 0.0});

  final double? wRatio;
  final double? hRatio;

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wRatio != null ? context.screenWidth * wRatio! : width,
      height: hRatio != null ? context.screenHeight * hRatio! : height,
    );
  }
}

// Gap for SLver Render Box

class SliverGap extends StatelessWidget {
  const SliverGap({super.key, this.hRatio, this.wRatio});
  final double? wRatio;
  final double? hRatio;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: wRatio != null ? context.screenWidth * wRatio! : null,
        height: hRatio != null ? context.screenHeight * hRatio! : null,
      ),
    );
  }
}
