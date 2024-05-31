import 'package:flutter/material.dart';

class Hometitle extends StatelessWidget {
  const Hometitle({super.key});

  @override
  Widget build(BuildContext context) {
    void tapper() {
      print("tapped");
    }

    return SizedBox(
      height: 40,
      // color: Colors.amber,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10), // Horizontal padding only
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Fview"),
            IconButton(
              onPressed: tapper,
              icon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
