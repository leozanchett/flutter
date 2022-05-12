import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hutcidade/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      home: Home(),
      theme: ThemeData(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Colors.brown,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
