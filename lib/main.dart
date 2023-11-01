import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

// mixins are abstract class that cannot have constructor
mixin CanRun {
  int get speed;

  // not abstract function, but logic function
  void run(){
    'Running at the speed of $speed'.log();
  }
}

class Cat with CanRun {
  
  //speed ကရှိကိုရှိရမယ်-ဒီလို assign လုပ်တယ်
  @override
  int speed=10;

}
//to test
void testIt() {
final cat = Cat();
cat.run();
cat.speed = 20;
cat.run();
}
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
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