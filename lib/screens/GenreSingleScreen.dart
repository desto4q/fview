import 'package:flutter/material.dart';

class GenreSingle extends StatelessWidget {
 const GenreSingle({super.key,required this.title, required this.id});
  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child:Text(id),),
      
    );
  }
}