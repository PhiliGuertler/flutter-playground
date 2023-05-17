import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverFancyImageHeader extends StatelessWidget {
  final double stretchTriggerOffset;
  final Future<void> Function()? onStretchTrigger;
  final double minHeight;
  final double height;
  final List<StretchMode> stretchModes;
  final String imageUrl;

  const SliverFancyImageHeader({
    super.key,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.minHeight = 0.0,
    this.height = 150.0,
    this.stretchModes = const [
      StretchMode.zoomBackground,
    ],
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: CustomDelegate(
        imageUrl: imageUrl,
        height: height,
        minHeight: minHeight,
        stretchConfiguration: OverScrollHeaderStretchConfiguration(
          stretchTriggerOffset: stretchTriggerOffset,
          onStretchTrigger: onStretchTrigger,
        ),
        stretchModes: stretchModes,
      ),
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double height;
  final List<StretchMode> stretchModes;
  final String imageUrl;

  const CustomDelegate({
    required this.imageUrl,
    required this.minHeight,
    required this.height,
    required this.stretchConfiguration,
    required this.stretchModes,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double currentExtent = math.max(height - shrinkOffset, minHeight);
    return FlexibleSpaceBar.createSettings(
      currentExtent: currentExtent,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(24.0),
        ),
        child: FlexibleSpaceBar(
          stretchModes: stretchModes,
          background: SizedBox(
            height: math.max(height - shrinkOffset, minHeight),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant CustomDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight || height != oldDelegate.height;
  }
}
