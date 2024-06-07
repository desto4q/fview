
import 'package:flutter/material.dart';
import 'package:fview/api/api.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:fview/utils/utils.dart';

class PopularCard extends StatelessWidget {
  const PopularCard(
      {super.key,
      required this.parent_height,
      required this.index,
      required this.results,
      required this.parent_width});
  final double parent_height;
  final double parent_width;
  final index;
  final List results;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.amber,
        width: parent_width * 14 / 16,
        height: parent_width * 16 / 14,
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                index["image"],
                fit: BoxFit.cover,
              ),
            )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.black26],
                        stops: [0.2, 1],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...addGaps([
                          Text(
                            index["title"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(index["releaseDate"]),
                          Row(
                            children: [
                              ...addGapsHorizontal([
                                IconButton(
                                  onPressed: () async {
                                    var resp = await getid(index["id"]);
                                    var details = {
                                      "id": resp["id"],
                                      "title": resp["title"],
                                      "image": resp['image'],
                                      "subOrDub": resp["subOrDub"],
                                    };
                                    print(details);
                                    addtoFav(details);
                                  },
                                  icon: Icon(Icons.favorite),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                    (states) => Colors.green.shade600,
                                  )),
                                ),
                                ElevatedButton(
                                    onPressed: () {
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
                                    child: Text("watch"))
                              ], 10)
                            ],
                          )
                        ], 5)
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
