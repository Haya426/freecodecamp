import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

//isolate အကြောင်းဖတ်မယ်
// event loop အကြောင်းဖတ်မယ်
// main isolate က app UI အတွက်သုံးတယ် 
//isolate တစ်ခုနဲ့တစ်ခု message passing အတွက် port ကိုသုံးတယ်


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

Future<Iterable<Person>> getPersons() async {
  final rp = ReceivePort();
  await Isolate.spawn(_getPersons,rp.sendPort);
  return await rp.first; // receipt port is stream 
}
//define function to send value via port
void _getPersons(SendPort sp) async {
  const url = 'http://127.0.0.1:5500/apis/people1.json';
  final persons = await HttpClient()
  .getUrl(Uri.parse(url))
  .then((req) => req.close())
  .then((reponse) => reponse.transform(utf8.decoder).join())
  .then((jsonString) => json.decode(jsonString)as List<dynamic>)
  .then((json) => json.map((map) => Person.fromJson(map)));
  
  Isolate.exit(sp,persons);
}
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: TextButton(onPressed: () async{
          final persons = await getPersons();
          persons.log();
        }, child: const Text('Press me'))
      ),
    );
  }
}