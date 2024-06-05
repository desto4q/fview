import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:clickable_widget/clickable_widget.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:fview/utils/utils.dart';

class AiringScreen extends HookWidget {
  const AiringScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Page state managed by a hook
    final page = useState(1);

    // Fetch data based on the current page
    final query =
        useQuery(["airingScreen", page.value], () => getTop(page.value));
    final results = query.data;

    return Scaffold(
      
      appBar: AppBar(
        toolbarHeight: 50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: page.value > 1
                  ? () {
                      page.value--;
                    }
                  : null,
            ),
            Text('Page ${page.value}'),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                page.value++;
              },
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: query.isLoading
            ? const Center(
                key: ValueKey('loading'), child: CircularProgressIndicator())
            : query.isError
                ? Center(
                    key: const ValueKey('error'),
                    child: Text(query.error!.toString()))
                : ListView.builder(
                    key: const ValueKey('list'),
                    itemCount: results["results"].length,
                    itemBuilder: (context, index) {
                      final item = results["results"][index];
                      return ClickableCard(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 140,
                                width: 140 * 12 / 16,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item["image"],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                  width:
                                      8), // Add some spacing between image and title
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...addGaps([
                                      Text(
                                        item["title"],
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Episodes: ${item["episodeNumber"].toString()}",
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                      Colors.grey.shade800),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  InfoPage(
                                                id:item["id"],
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
                                                    .chain(CurveTween(
                                                        curve: curve));

                                                return SlideTransition(
                                                  position:
                                                      animation.drive(tween),
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text("Watch"),
                                      ),
                                    ], 10)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
