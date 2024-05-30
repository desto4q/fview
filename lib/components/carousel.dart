import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';

class Carousel extends HookWidget {
  const Carousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = useQuery(["data"], () => getPopular(1));

    if (data.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (data.isError) {
      return Center(child: Text(data.error!.toString()));
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final List<Widget> carouselItems = data.data["results"].map<Widget>((item) {
      return Builder(
        builder: (BuildContext context) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double parentWidth = constraints.maxWidth;
              // print(parentWidth);

              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: parentWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        // color: Colors.red
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              
                              width:
                                  parentWidth, // Example usage of parent width
                              child: Text(
                                item["title"],
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width:
                                  parentWidth, // Example usage of parent width
                              child: Text(
                                item["releaseDate"],
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }).toList();

    return CarouselSlider(
      items: carouselItems,
      options: CarouselOptions(
        height: screenHeight * 0.6,
        enlargeCenterPage: true,
      ),
    );
  }
}
