import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/components/carousel.dart';
import '../api/api.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text("home"),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [Carousel()],
        ),
      ),
    );
  }
}
