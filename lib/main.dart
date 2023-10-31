import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object{
  void log() => devtools.log(toString());
}
// mixin mean to implement functions from many abstract classes
abstract class CanRun{

  void run(){
    'Running...'.log();
  } 
}
abstract class CanWalk {
  void walk(){
    'Walking...'.log();
  }
}

class Cat with CanRun, CanWalk {} //abstract class မှာ contructor မရှိလို့ mixin လုပ်လို့ရတာဖြစ်



void testIt(){
   
   final cat = Cat();
   cat
   ..run()
   ..walk();
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