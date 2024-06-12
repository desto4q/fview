import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorComp extends StatelessWidget {
  ErrorComp({
    super.key,
    required this.refetch,
  });
  final void Function() refetch;
  @override
  Widget build(BuildContext context) {
    return Center(
          child: ElevatedButton(onPressed: refetch, child: Text("refetch")),
        );
  }
}
