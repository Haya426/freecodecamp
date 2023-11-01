import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

// Let's now talk about constraint on mixin
// This allow you to limit who the mixin can be used on

abstract class Animal {
  const Animal();
}
// Animal abstract class အတွက်ပဲသုံးလို့ရမယ်ဆိုပြီးသတ်မှတ်လိုက်တာဖြစ်
mixin CanRun on Animal{ 
  int get speed;

  // not abstract function, but logic function
  void run(){
    'Running at the speed of $speed'.log();
  }
}
//ပြီးရင် ဒီမှာ cat က Animal ကို extendsလာလုပ်
class Cat extends Animal with CanRun { 
  
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