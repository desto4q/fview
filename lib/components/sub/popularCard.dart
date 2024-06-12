import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fview/api/api.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:fview/utils/utils.dart';
import 'package:hive/hive.dart';

class PopularCard extends HookWidget {
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
  Widget build(BuildContext context) {
    var FavBox = Hive.box("favorites");
    var Item_exists = useState(FavBox.get(index["id"]));
    // print(Item_exists.value);
    return Container(
      width: parent_width * 14 / 16,
      height: parent_width * 16 / 14,
      padding: EdgeInsets.all(6),
      child: Column(
        children: [
          // Text(index["image"]),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(index["image"], fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      // backgroundBlendMode: BlendMode,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.black26],
                        stops: [0.2, 1],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...addGaps([
                          // Text(Item_exists.value != null
                          //     ? jsonDecode(Item_exists.value)["id"]
                          //     : "null"),
                          Text(
                            index["title"],
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 1,
                          ),
                          Text(
                            index["releaseDate"],
                          ),
                          Row(
                            children: [
                              ...addGapsHorizontal([
                                Material(
                                  child: InkWell(
                                    onTap: () async {
                                      //  Show "Adding..." snackbar

                                      try {
                                        // Perform the operation
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        const addingSnack = SnackBar(
                                          content: Text("adding"),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(addingSnack);
                                        var resp = await getid(index["id"]);
                                        var details = {
                                          "id": resp["id"],
                                          "title": resp["title"],
                                          "image": resp['image'],
                                          "subOrDub": resp["subOrDub"],
                                        };
                                        await addtoFav(details);
                                        Item_exists.value =
                                            FavBox.get(index["id"]);

                                        // If successful, show "Added" snackbar
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
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
                                            .showSnackBar(addedSnackBar);
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
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade800,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      padding: const EdgeInsets.all(4),
                                      child: AnimatedSwitcher(
                                        transitionBuilder: (Widget child,
                                            Animation<double> animation) {
                                          return FadeTransition(
                                              opacity: animation, child: child);
                                        },
                                        key: ValueKey<bool>(
                                            FavBox.containsKey(index["id"])),
                                        duration:
                                            const Duration(milliseconds: 800),
                                        child: Item_exists.value == null
                                            ? const Icon(Icons.favorite)
                                            : const Icon(Icons.check),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(4),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              InfoPage(
                                            id: index["id"],
                                          ),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.easeInOut;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 6),
                                      child: const Text("watch"),
                                    ),
                                  ),
                                )
                              ], 10)
                            ],
                          ),
                        ], 4)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
