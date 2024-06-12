import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/screens/GenreSingleScreen.dart';

class GenreList extends HookWidget {
  const GenreList({super.key});

  @override
  Widget build(BuildContext context) {
    final genrelistQuery = useQuery(["genreList"], () => getGenrelist());

    return SafeArea(
        child: genrelistQuery.isLoading
            ? Center(
                child: Text("loading"),
              )
            : genrelistQuery.isError
                ? Center(
                    child: Text("error"),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: EdgeInsets.all(10),
                    children: [
                      for (var i = 0; i < genrelistQuery.data.length; i++)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        GenreSingle(
                                          id:genrelistQuery.data[i]["id"] ,
                                          title: genrelistQuery.data[i]["title"],
                                        ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          // elevation: 10,
                          // color: Colors.grey.shade800,
                          child: Center(
                            child: Text(
                                genrelistQuery.data[i]["title"].toString()),
                          ),
                        )
                    ],
                  ));
  }
}
