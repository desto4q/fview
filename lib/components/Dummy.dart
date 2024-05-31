import 'package:flutter/material.dart';

class Dummy extends StatelessWidget {
  const Dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: 12,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.all(10),
              color: Colors.amber,
            );
          }),
    );
  }
}
