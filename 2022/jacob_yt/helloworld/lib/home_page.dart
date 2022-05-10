import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helloworld/myapp.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = HomeController.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: const Text('Home'),
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (kDebugMode) {
//             controller.increment();
//           }
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.amber,
//       ),
//       body: MyApp(value: controller.value),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  @override
  void initState() {
    if (kDebugMode) {
      print('initState');
    }
    super.initState();
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('dispose');
    }
    super.dispose();
  }

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
            setState(() => counter++);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: MyApp(value: counter),
    );
  }
}
