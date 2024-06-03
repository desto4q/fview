import 'package:flutter/material.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:fview/utils/utils.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.results, required this.index});
  final results;
  final index;

  @override
  Widget build(BuildContext context) {
    final image_src = results[index]["image"];
    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade900,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ...addGapsHorizontal([
                Container(
                  height: 200,
                  width: 200 * 12 / 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    image_src,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // height: ,
                  width: MediaQuery.of(context).size.width - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...addGaps([
                        Text(
                          results[index]["title"],
                          softWrap: true,
                        ),
                        Text(
                          results[index]["releaseDate"],
                          softWrap: true,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber.shade600,
                          ),
                          child: Text(
                            results[index]["subOrDub"],
                            style: const TextStyle(color: Colors.black),
                            softWrap: true,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      InfoPage(id: results[index]["id"]),
                                ),
                              );
                            },
                            child: Text("watch"))
                      ], 10)
                    ],
                  ),
                ),
              ], 10)
            ],
          ),
        ),
      ),
    );
  }
}
