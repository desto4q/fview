import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/paginator.dart';
import 'package:fview/components/videoapp.dart';
import 'package:fview/utils/utils.dart';

class WatchScreen extends HookWidget {
  const WatchScreen({super.key, this.episode, this.item_id});
  final episode;
  final item_id;

  @override
  Widget build(BuildContext context) {
    final query = useQuery([episode], () => getEpisode(episode));
    final details_query =
        useQuery([item_id["id"], "watchscreen"], () => getid(item_id["id"]));
    if (query.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (query.isError) {
      return Center(child: Text(query.error!.toString()));
    }

    final results = query.data;
    final finUrl = useState(results["sources"][0]["url"]);
    final ValueNotifier<String> notifier = ValueNotifier(finUrl.value);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          MyScreen(url: finUrl.value),
          // Text(item_id["id"].toString()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: addGapsHorizontal(
                    results["sources"].map<Widget>((source) {
                      return ElevatedButton(
                          onPressed: () {
                            finUrl.value = source["url"];
                          },
                          child: Text(source[
                              "quality"])); // You can replace this with your actual widget
                    }).toList(),
                    10),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(episode.toString()),
                    details_query.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : details_query.isError
                            ? Center(
                                child: ElevatedButton(
                                  child: Text("reload"),
                                  onPressed: () {},
                                ),
                              )
                            : Paginator(
                                items: details_query.data["episodes"],
                                item_id: item_id,
                              )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
