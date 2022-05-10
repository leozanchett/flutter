import 'package:flutter/material.dart';
import 'package:helloworld/home_page.dart';

void main() {
  runApp(const GoAPP());
}

class GoAPP extends StatelessWidget {
  const GoAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Go',
      home: HomePage(),
    );
  }
}
