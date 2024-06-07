import 'package:flutter/material.dart';
import 'package:fview/utils/utils.dart';
import 'package:hive/hive.dart';

class FavCard extends StatefulWidget {
  const FavCard({super.key,required this.decoded, required this.FavBox,required this.FavBoxLength});
  final decoded;
  final Box FavBox;
  final FavBoxLength;



  @override
  State<FavCard> createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
                  // padding: const EdgeInsets.all(3),
                  child: Column(
                    children: [
                      ...addGaps([
                        Flexible(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.decoded["image"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            widget.decoded["title"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    showAdaptiveDialog(
                                        context: context,
                                        builder: (_) {
                                          return Container(
                                            child: Center(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                color: Colors.grey.shade700,
                                                child: IntrinsicHeight(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ...addGaps([
                                                        Text(
                                                            "Are You Sure you want to delete "),
                                                        Container(
                                                          width: 200,
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          child: Text(
                                                            widget.decoded["title"],
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .amber),
                                                          ),
                                                        ),
                                                        IntrinsicWidth(
                                                          child: Row(
                                                            children: [
                                                              ...addGapsHorizontal(
                                                                  [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await FavBox.delete(
                                                                            widget.decoded["id"]);
                                                                        setState(
                                                                            () {
                                                                          FavBoxLength = FavBox
                                                                              .values
                                                                              .length;
                                                                        });
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child: Text(
                                                                          "yes"),
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "no"),
                                                                    )
                                                                  ],
                                                                  10)
                                                            ],
                                                          ),
                                                        ),
                                                      ], 4)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.delete_rounded,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ])
                      ], 4)
                    ],
                  ),
                );
  }
}