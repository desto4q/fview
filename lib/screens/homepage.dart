import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fview/components/carousel.dart';
import 'package:fview/components/recent_releases.dart';
import 'package:fview/components/sub/hometitle.dart';
import 'package:fview/components/top_airing.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: addGaps(
            const [Hometitle(), Carousel(), TopAiringComp(),RecentReleaseComp()],
            10,
          ),
        ),
      ),
    );
  }

  List<Widget> addGaps(List<Widget> items, double gapHeight) {
    List<Widget> spacedItems = [];
    for (var i = 0; i < items.length; i++) {
      spacedItems.add(items[i]);
      if (i < items.length - 1) {
        spacedItems.add(SizedBox(height: gapHeight)); // Add gap between items
      }
    }
    return spacedItems;
  }
}
