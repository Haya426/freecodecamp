import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object{
  void log() => devtools.log(toString());
}

abstract class CanRun{
  void run();
}

// extends keyword can extend one abstract class
// To extend mutiple classes, 'with' keyword must be applied
class Cat extends CanRun {
  @override
  void run() {
    // TODO: implement run
  }

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: const Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}