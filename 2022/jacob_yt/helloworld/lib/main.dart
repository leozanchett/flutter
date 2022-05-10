import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: Center(
        child: Container(
          width: 150,
          height: 50,
          color: Colors.white,
          child: const Center(
            child: Text('data'),
          ),
        ),
      ),
    );
  }
}
