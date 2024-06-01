import 'package:flutter/material.dart';
import 'package:fview/utils/utils.dart';

class Paginator extends StatefulWidget {
  const Paginator({super.key, required this.items});
  final List items;

  @override
  State<Paginator> createState() => _PaginatorState();
}

class _PaginatorState extends State<Paginator> {
  static const int itemsPerPage = 10;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    List pagedEpisodes = widget.items.sublist(
      startIndex,
      endIndex > widget.items.length ? widget.items.length : endIndex,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Display the paginated items
          ...pagedEpisodes.map((episode) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Episode: ${episode["number"]}"),
                        )),
                  ),
                ],
              )),
          // Pagination buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...addGapsHorizontal([
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 0;
                      });
                    },
                    child: const Text('<<'),
                  ),
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage--;
                      });
                    },
                    child: const Text('<'),
                  ),
                if (endIndex < widget.items.length)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage++;
                      });
                    },
                    child: const Text('>'),
                  ),
                if (endIndex < widget.items.length)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage =
                            (widget.items.length / itemsPerPage).ceil() - 1;
                      });
                    },
                    child: const Text('>>'),
                  ),
              ], 10)
            ],
          ),
        ],
      ),
    );
  }
}
