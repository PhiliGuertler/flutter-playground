import 'package:flutter/material.dart';

import 'sliver_fancy_image_header.dart';

class PlaygroundScreen extends StatelessWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ja moin!")),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            const SliverFancyImageHeader(
              imageUrl:
                  "https://static1.cbrimages.com/wordpress/wp-content/uploads/2020/12/oh-youre-approaching-me.jpg",
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
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
