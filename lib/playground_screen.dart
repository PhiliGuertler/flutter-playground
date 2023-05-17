import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class PlaygroundScreen extends StatelessWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            // SliverAppBar(
            //   expandedHeight: 300.0,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Image.network(
            //       "https://www.br.de/radio/puls/puls-meme-100~_v-img__16__9__l_-1dc0e8f74459dd04c91a0d45af4972b9069f1135.jpg?version=eb278",
            //       fit: BoxFit.cover,
            //     ),
            //     stretchModes: const [
            //       StretchMode.blurBackground,
            //       StretchMode.zoomBackground,
            //     ],
            //   ),
            //   stretch: true,
            // ),
            SliverPersistentHeader(
              delegate: CustomDelegate(
                stretchConfiguration: OverScrollHeaderStretchConfiguration(
                  stretchTriggerOffset: 300.0,
                  onStretchTrigger: () async {},
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList.list(children: [
                Container(height: 160, color: Colors.amber),
                Container(height: 160, color: Colors.cyanAccent),
                Container(height: 160, color: Colors.deepOrange),
                Container(height: 160, color: Colors.indigoAccent),
                Container(height: 160, color: Colors.lightBlueAccent),
                Container(height: 160, color: Colors.limeAccent),
                Container(height: 160, color: Colors.red),
              ]),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("You reached the rock bottom"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double height;

  const CustomDelegate({
    this.minHeight = 30.0,
    this.height = 300.0,
    required this.stretchConfiguration,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double currentExtent = math.max(height - shrinkOffset, minHeight);
    return FlexibleSpaceBar.createSettings(
      currentExtent: currentExtent,
      child: FlexibleSpaceBar(
        stretchModes: const [
          // StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
        background: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(24.0),
          ),
          child: SizedBox(
            height: math.max(height - shrinkOffset, minHeight),
            child: Image.network(
              "https://www.br.de/radio/puls/puls-meme-100~_v-img__16__9__l_-1dc0e8f74459dd04c91a0d45af4972b9069f1135.jpg?version=eb278",
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
