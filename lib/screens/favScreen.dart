import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fview/components/favCard.dart';
import 'package:hive/hive.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  Box FavBox = Hive.box("favorites");
   int FavBoxLength=0;

  @override
  void initState() {
    super.initState();
    FavBoxLength = FavBox.length;
  }

  void updateFavBoxLength(int newLength) {
    setState(() {
      FavBoxLength = newLength;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("favorites"),
                ),
                Material(
                  color: Colors.green.shade700,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      setState(() {
                        FavBoxLength = FavBox.values.length;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: const Text(
                        "reload",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: FavBoxLength,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 10 / 16,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  maxCrossAxisExtent: 220,
                ),
                itemBuilder: (_, index) {
                  final imageLink = FavBox.getAt(index);
                  final _decoded = jsonDecode(imageLink);
                  return FavCard(
                    FavBoxLength: FavBoxLength,
                    decoded: _decoded,
                    FavBox: FavBox,
                    updateFavBoxLength: updateFavBoxLength, // Pass the callback
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
