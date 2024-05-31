import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/videoapp.dart';

class WatchScreen extends HookWidget {
  const WatchScreen({super.key, this.episode, this.item_id});
  final episode;
  final item_id;

  @override
  Widget build(BuildContext context) {
    final query = useQuery([episode], () => getEpisode(episode));
    if (query.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (query.isError) {
      return Center(child: Text(query.error!.toString()));
    }
    final results = query.data;
    final finUrl = results["sources"][0]["url"];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          MyScreen(url:finUrl)
        ],
      ),
    );
  }
}
