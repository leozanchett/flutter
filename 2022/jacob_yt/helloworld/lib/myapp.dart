import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.value}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 50,
        color: Colors.white,
        child: Center(
          child: Text(value.toString()),
        ),
      ),
    );
  }
}
