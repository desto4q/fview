import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    print(id);
    return  Scaffold(
      appBar: AppBar(),
    );
  }
}
