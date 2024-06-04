import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/sub/searchCard.dart';
import 'package:fview/utils/utils.dart';

class SearchPage extends HookWidget {
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTrm = useState<String>("naruto");
    final page = useState<int>(1);
    final myController = TextEditingController();
    final query = useQuery([searchTrm.value, page.value],
        () => getApi(page.value, searchTrm.value));
    // final results = ;

    void incrementPage() {
      page.value++;
    }

    void decrementPage() {
      if (page.value > 1) {
        page.value--;
      }
    }

    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: myController,
                    decoration:
                        const InputDecoration(hintText: "search here...."),
                  ),
                ),
                IconButton(
                  color: Colors.grey.shade800,
                  onPressed: () {
                    if (myController.text.length > 0) {
                      searchTrm.value = myController.text;
                      page.value = 1;
                    } else {}
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...addGapsHorizontal([
                  IconButton(
                      onPressed: decrementPage, icon: Icon(Icons.remove)),
                  Text(page.value.toString()),
                  IconButton(onPressed: incrementPage, icon: Icon(Icons.add)),
                ], 10)
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: query.isLoading
                    ? const Center(
                        key: ValueKey('loading'),
                        child: CircularProgressIndicator())
                    : query.isError
                        ? Center(
                            key: const ValueKey('error'),
                            child: Text(query.error!.toString()))
                        : ListView.builder(
                            key: const ValueKey('list'),
                            itemCount: query.data["results"].length,
                            itemBuilder: (context, index) {
                              final item = query.data["results"][index];
                              return SearchCard(
                                index: index,
                                results: query.data["results"],
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
