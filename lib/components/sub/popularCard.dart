import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fview/api/api.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:fview/utils/utils.dart';
import 'package:hive/hive.dart';

class PopularCard extends StatefulWidget {
  const PopularCard({
    super.key,
    required this.parent_height,
    required this.index,
    required this.results,
    required this.parent_width,
  });
  final double parent_height;
  final double parent_width;
  final index;
  final List results;

  @override
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  String? cardId;

  @override
  void initState() {
    super.initState();
    final FavBox = Hive.box("favorites");
    cardId = FavBox.get(widget.index["id"]);
  }

  @override
  Widget build(BuildContext context) {
    final FavBox = Hive.box("favorites");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: widget.parent_width * 14 / 16,
        height: widget.parent_width * 16 / 14,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.index["image"],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.black26],
                    stops: [0.2, 1],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...addGaps([
                        Text(
                          widget.index["title"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.index["releaseDate"]),
                        Row(
                          children: [
                            ...addGapsHorizontal([
                              Material(
                                color: Colors.green.shade800,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () async {
                                    // Show "Adding..." snackbar
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    final addingSnackBar = SnackBar(
                                      content: const Text('Adding...'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(addingSnackBar);

                                    try {
                                      // Perform the operation
                                      var resp = await getid(widget.index["id"]);
                                      var details = {
                                        "id": resp["id"],
                                        "title": resp["title"],
                                        "image": resp['image'],
                                        "subOrDub": resp["subOrDub"],
                                      };
                                      addtoFav(details);

                                      // If successful, show "Added" snackbar
                                      final addedSnackBar = SnackBar(
                                        content: const Text('Added'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(addedSnackBar);

                                      setState(() {
                                        cardId = FavBox.get(widget.index["id"]);
                                      });
                                    } catch (e) {
                                      // If there is an error, show "Failed to add" snackbar
                                      final failedSnackBar = SnackBar(
                                        content: const Text('Failed to add'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(failedSnackBar);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 300),
                                      transitionBuilder: (Widget child, Animation<double> animation) {
                                        return ScaleTransition(child: child, scale: animation);
                                      },
                                      child: Icon(
                                        cardId == null
                                            ? Icons.favorite
                                            : Icons.check,
                                        key: ValueKey(cardId),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          InfoPage(
                                        id: widget.index["id"],
                                      ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text("watch"),
                              ),
                            ], 10),
                          ],
                        ),
                      ], 5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
