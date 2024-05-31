import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/paginator.dart';
import 'package:fview/utils/utils.dart';

class InfoPage extends HookWidget {
  const InfoPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final query = useQuery([id], () => getid(id));
    if (query.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (query.isError) {
      return Center(child: Text(query.error!.toString()));
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final results = query.data;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ...addGaps([
                SizedBox(
                  height: height * 0.7,
                  width: width * 0.66,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        query.data["image"],
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                    // color: Colors.amber,
                    width: width * 0.66,
                    child: Column(
                      children: [
                        ...addGaps([
                          Text(results["title"]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...addGapsHorizontal([
                                Text(results["releaseDate"]),
                                Text(results["subOrDub"]),
                                Text(results["status"]),
                                Text("Episodes: ${results["totalEpisodes"]}"),
                              ], 10)
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ExpandableText(results["description"],
                                collapseText: "show less",
                                maxLines: 1,
                                linkColor: Colors.blue.shade300,
                                expandText: "show more"),
                          )
                        ], 10),
                        Paginator(items: results["episodes"])
                      ],
                    )),
              ], 10),
            ],
          ),
        ),
      ),
    );
  }
}
