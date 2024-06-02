import 'package:flutter/material.dart';
import 'package:fview/utils/utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CarouselItem extends StatefulWidget {
  const CarouselItem({super.key, this.item, required this.parentWidth});
  final item;
  final double parentWidth;
  
  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  Color defaultColor = const Color.fromARGB(255, 129, 70, 70);
  @override
  void initState() {
    super.initState();
    _fetchColor();
  }

  void _fetchColor() async {
    final color = await pickColor(widget.item["image"]);
    if (mounted) {
      setState(() {
        defaultColor = color!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final contwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.item["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 420-20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black45, Colors.transparent],
                  stops: [.2, .9, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                // color: Colors.red
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width:
                          widget.parentWidth, // Example usage of parent width
                      child: Text(
                        widget.item["title"],
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width:
                          widget.parentWidth, // Example usage of parent width
                      child: Text(
                        widget.item["releaseDate"],
                        softWrap: true,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ...addGapsHorizontal([
                          IconButton.filled(
                              iconSize: 22,
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              color: Colors.black,
                              onPressed: () {
                                showCupertinoModalBottomSheet(
                                  enableDrag: true,
                                    context: context,
                                    builder: (context) => Container(
                                      color: Colors.amber,
                                    ));
                              },
                              icon: const Icon(Icons.favorite)),
                          ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, "/info",
                                    arguments: widget.item["id"]);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent.shade700,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: const Text("play"))
                        ], 10)
                      ],
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
