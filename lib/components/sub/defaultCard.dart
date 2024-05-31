import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:fview/screens/WatchScreen.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({super.key, required this.results, required this.index});
  final results;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            width: 200,
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ClickableImage(
                clickableImageType: ClickableImageType.network,
                onTap: () {
                  Navigator.pushNamed(context, "/info",
                      arguments: results[index]["id"]);
                },
                src: results[index]["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ), // Add some spacing between image and text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              results[index]["title"],
              textAlign: TextAlign.center,
              maxLines: 1, // Set max lines to 2
              overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
            ),
          ),
          // SizedBox(
          //   height: 2,
          // ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.amber.shade700),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WatchScreen(
                                    item_id: results[index],
                                    episode: results[index]["episodeId"],
                                  )));
                    },
                    child: Text(
                      'EP:${results[index]["episodeNumber"].toString()}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
