import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hutcidade/home.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: const Home(),
      theme: ThemeData(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Colors.brown,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
