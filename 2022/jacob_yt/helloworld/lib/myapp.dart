import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 50,
        color: Colors.white,
        child: const Center(
          child: Text('teste'),
        ),
      ),
    );
  }
}
