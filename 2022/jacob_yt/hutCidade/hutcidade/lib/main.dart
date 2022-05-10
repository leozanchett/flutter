import 'package:flutter/material.dart';
import 'package:hutcidade/home.dart';

void main() {
  runApp(
    MaterialApp(
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
