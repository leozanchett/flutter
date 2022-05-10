import 'package:flutter/material.dart';

class HomeController extends InheritedNotifier<ValueNotifier<int>> {
  HomeController({Key? key, required Widget child})
      : super(
          key: key,
          child: child,
          notifier: ValueNotifier<int>(0),
        );

  void increment() => notifier!.value++;

  int get value => notifier!.value;

  static HomeController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeController>()!;
}
