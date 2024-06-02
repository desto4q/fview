import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/sub/defaultCard.dart';
import 'package:fview/screens/recentrelease_screen.dart';

class RecentReleaseComp extends HookWidget {
  const RecentReleaseComp({super.key});

  @override
  Widget build(BuildContext context) {
    final query = useQuery(["RecentRelease"], () => getRecent(1));

    if (query.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (query.isError) {
      return Center(child: Text(query.error!.toString()));
    }

    if (query.data == null || !query.data.containsKey('results')) {
      return const Center(child: Text('No data available'));
    }

    final List<dynamic> results = query.data["results"];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "RecentRelease",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecentScreen()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("See more"),
                  style: ElevatedButton.styleFrom(
                      // Change the text color here
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 350,
            child: ListView.builder(
              itemCount: results.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return DefaultCard(results: results, index: index);
              },
            ),
          ),
          // You can add more widgets here if needed
        ],
      ),
    );
  }
}
