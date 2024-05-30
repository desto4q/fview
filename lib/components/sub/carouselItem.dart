import 'package:flutter/cupertino.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        image,
      ),
    );
  }
}
