import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object{
  void log() => devtools.log(toString());
}
//Abstract class can have contructors
//When an abstract class has a constructor,it cannot be mixed into other classes
// for example, class Cat with CanRun{} will araise error
//ဆိုလိုချင်တာ abstract class မှာ contructor ရှိပြီဆိုတာနဲ့ mixin feature မရတော့ဘူး
enum Type {cat,dog}

abstract class CanRun{
  final Type type;
  //constructor
  const CanRun({required this.type});

  @mustCallSuper // it push to invoke super class, 
  void run(){
    
    "can run function is called".log();
  } // normal function
}


class Cat extends CanRun {
  const Cat(): super(type:Type.cat);
  @override
  void run() { // If empty body does not invoke super class
    super.run();
    'cat running'.log();

  }
}
class Dog extends CanRun {
  const Dog(): super(type:Type.dog);

}

void testIt(){
    final cat  = Cat(); // 'this' is now Cat
    cat.type.log();  
    final dog = Dog(); // 'this' is now Dog
    dog.type.log();
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