import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helloworld/myapp.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Home'),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print('Clicou no botão');
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: MyApp(),
    );
  }
}
