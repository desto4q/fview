import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/api/api.dart';
import 'package:fview/components/sub/popularCard.dart';

class PopularComp extends HookWidget {
  const PopularComp({super.key});

  @override
  Widget build(BuildContext context) {
    final query = useQuery(["popular"], () => getPopular(1));

   

    // if (query.data == null || !query.data.containsKey('results')) {
    //   return Center(
    //       child: ElevatedButton(
    //     onPressed: query.refetch,
    //     child: Text("refetch"),
    //   ));
    // }

    // final List<dynamic> results = query.data?["results"];
    final height = MediaQuery.of(context).size.height * 0.7;
    final width = MediaQuery.of(context).size.width;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: width * 17/14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: query.isLoading
              ? const Center(child: CircularProgressIndicator())
              : query.isError
                  ? Center(
                      child: ElevatedButton(
                      onPressed: query.refetch,
                      child: Text("refetch"),
                    ))
                  : Row(
                      children: [
                        ...query.data["results"].map((e) => PopularCard(
                              parent_height: height - 10,
                              parent_width: width,
                              results: query.data["results"],
                              index: e,
                            ))
                      ],
                    ),
        ),
      ),
    );
  }
}
