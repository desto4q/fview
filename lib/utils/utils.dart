import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

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
List<Widget> addGapsHorizontal(List<Widget> items, double gapWidth) {
  List<Widget> spacedItems = [];
  for (var i = 0; i < items.length; i++) {
    spacedItems.add(items[i]);
    if (i < items.length - 1) {
      spacedItems.add(SizedBox(width: gapWidth)); // Add gap between items
    }
  }
  return spacedItems;
}

Future<Color?> pickColor(String url) async {
  try {
    var pallete = PaletteGenerator.fromImageProvider(NetworkImage(url));
    return pallete.then((value) => value.dominantColor?.color);
  } catch (err) {
    rethrow;
  }
}
