import 'package:clickable_widget/clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:fview/components/infomodal.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:fview/screens/WatchScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
                onLongPress: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => InfoModal(
                      id: results[index]["id"],
                      controller: ModalScrollController.of(context),
                    ),
                  );
                },
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => InfoPage(
                        id: results[index]["id"],
                      ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
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
              maxLines: 1, // Set max lines to 1
              overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
            ),
          ),
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
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => WatchScreen(
                            item_id: results[index],
                            episode: results[index]["episodeId"],
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
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
