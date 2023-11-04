import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

//အရင်program မှာဆိုရင် persons ကိုတစ်ခါပဲပြန်လိုက်တယ်
// receive port က stream ဖြစ်တဲ့အတွက် တန်ဖိုးတွေ continuously communicate လုပ်နိင်ဖို့လိုတယ်
// အဲဒီတော့ အခုတစ်ခါ data ကို 10 ကြိမ် stream နဲ့ communicate လုပ်ကြရအောင်


void main() {
  runApp(MyApp());
}

@immutable
class Person {
  final String name;
  final int age;

 const Person({
  required this.name, 
  required this.age});
  Person.fromJson(Map<String,dynamic> json):
  name = json["name"] as String,
  age = json["age"] as int;
}

Stream<String> getMessages(){
  final rp = ReceivePort();
  return Isolate.spawn(_getMessages,rp.sendPort)
  .asStream() // steam ပြောင်းမယ်
  .asyncExpand((_) => rp) //change to receive port data type
  .takeWhile((element) => element is String) // string ဖြစ်တဲ့ဟာတွေကိုပဲရွေးသွားမယ်
  .cast();
}
void _getMessages(SendPort sp) async {
  await for (final now in  Stream.periodic(
    const Duration(seconds: 1),
    (_)=> DateTime.now().toIso8601String()).take(10)){
      sp.send(now);
    }
    Isolate.exit(sp,); //အဆုံးမှာဘာမှ မထည့်ပေးလိုက်ဘူး
    // Isolate.exit(sp,'hello'); အဆုံးမှာ hello ကို append လုပ်လိုက်တယ်
}

void testIt() async {
  await for (final msg in getMessages()){
    msg.log();
  }
}
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: TextButton(onPressed: () {
          testIt();
        }, child: const Text('Press me'))
      ),
    );
  }
}