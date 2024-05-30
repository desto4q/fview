import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key, this.hello});
  final String placeholder = "damn";
  final String? hello;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hello ?? placeholder)),
      body: Center(
        child: Text(hello ?? placeholder),
      ),
    );
  }
}
