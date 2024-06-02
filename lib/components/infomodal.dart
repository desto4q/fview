import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/paginator.dart';

class InfoModal extends HookWidget {
  const InfoModal({super.key, required this.id,this.controller});
  final String id;
  final controller;

  @override
  Widget build(BuildContext context) {
    final query = useQuery([id,"InfoModal"], () => getid(id));

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: query.isLoading
            ? const Center(child: CircularProgressIndicator())
            : query.isError
                ? Center(child: Text(query.error!.toString()))
                : SingleChildScrollView(
                  controller: controller,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                query.data["image"],
                                height: height * 0.7,
                                width: width * 0.9,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    query.data["title"],
                                    style: Theme.of(context).textTheme.titleLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(query.data["releaseDate"]),
                                      Text(query.data["subOrDub"]),
                                      Text(query.data["status"]),
                                      Text("Episodes: ${query.data["totalEpisodes"]}"),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ExpandableText(
                                      query.data["description"],
                                      collapseText: "show less",
                                      expandText: "show more",
                                      maxLines: 3,
                                      linkColor: Colors.blue.shade300,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Paginator(items: query.data["episodes"]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
