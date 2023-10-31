import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object{
  void log() => devtools.log(toString());
}
// 'Abstract' mean no logic or empty
// 'no abstract' means logic

abstract class CanRun{
  @mustCallSuper // it push to invoke super class, 
  void run(){
    "can run function is called".log();
  } // normal function
}

class Cat extends CanRun {
  @override
  void run() { // If empty body does not invoke super class
    super.run();
    'cat running'.log();

  }
}

void testIt(){
    final cat  = Cat();
    cat.run();
  }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //invoke test function
    testIt();

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