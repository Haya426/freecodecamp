import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

//use future.wait() if you want result
//use future.forEach() if you don't care about result

extension Log on Object {
  void log() => devtools.log(toString());
}
@immutable
class Person {
  final String name;
  final int age;

  const Person({ 
    required this.name, 
    required this.age});

  Person.fromJson(Map<String,dynamic> json) :
  name = json["name"] as String,
  age = json["age"] as int;
  
  @override
  String toString() => 'Person ($name, $age years old )';
}
mixin ListOfThingsAPI<T> {

Future<Iterable<T>> get(String url) => HttpClient()
.getUrl(Uri.parse(url))
.then((req) => req.close())
.then((resp) => resp.transform(utf8.decoder).join())
.then((str) => json.decode(str) as List<dynamic>)
.then((list) => list.cast());
}

class GetApiEndPoints with ListOfThingsAPI<String> {
} 
class GetPeople with ListOfThingsAPI<Map<String,dynamic>> {
  Future<Iterable<Person>> getPeople(String url) => 
  get(url).then((jsons) => jsons.map((json) => Person.fromJson(json)));
}
void testIt() async {
final people = await GetApiEndPoints().get('http://127.0.0.1:5500/apis/apis.json')
.then((urls) => Future.wait(
  urls.map((url) => GetPeople().getPeople(url))
));
 people.log();
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
        body: TextButton(onPressed: () {
          testIt();
        }, child: const Text('Press me'))
      ),
    );
  }
}