import 'package:flutter/material.dart';

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
              child: Image.network(
                results[index]["image"],
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
                      Navigator.pushNamed(context, "/info",arguments: "passed String");
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
