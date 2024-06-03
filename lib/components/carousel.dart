import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/sub/carouselItem.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class Carousel extends HookWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    final query = useQuery(["data"], () => getPopular(1));

    if (query.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (query.isError) {
      return Center(child: Text(query.error!.toString()));
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final List<dynamic> results = query.data["results"];

    final List<Widget> carouselItems = results.map<Widget>((item) {
      return Builder(
        builder: (BuildContext context) {
          return CarouselItem(
            parentWidth: MediaQuery.of(context).size.width,
            item: item,
          );
        },
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Popular Anime",
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: screenHeight * 0.7,
          child: InfiniteCarousel.builder(
            itemCount: results.length,
            itemExtent: 420,
            anchor: 0.0,
            velocityFactor: 0.2,
            center: false,
            loop: true,
            physics: const BouncingScrollPhysics(), // Enable finger drag
            itemBuilder: (context, itemIndex, realIndex) {
              final item = results[itemIndex];
              return CarouselItem(
                parentWidth: MediaQuery.of(context).size.width,
                item: item,
              );
            },
          ),
        ),
      ],
    );
  }
}
