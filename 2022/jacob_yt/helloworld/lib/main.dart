import 'package:flutter/material.dart';
import 'package:helloworld/home_controller.dart';
import 'package:helloworld/home_page.dart';

void main() {
  runApp(const GoAPP());
}

class GoAPP extends StatelessWidget {
  const GoAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go',
      home: HomeController(
        child: const HomePage(),
      ),
    );
  }
}
