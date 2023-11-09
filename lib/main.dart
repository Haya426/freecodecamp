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

const people1Url = 'http://127.0.0.1:5500/apis/people1.json';
const people2Url = 'http://127.0.0.1:5500/apis/people23.json';

Future<Iterable<Person>> parseJson(String url) =>HttpClient()
.getUrl(Uri.parse(url))
.then((req) => req.close())
.then((resp) => resp.transform(utf8.decoder).join())
.then((str) => json.decode(str) as List<dynamic>)
.then((json) => json.map((e) => Person.fromJson(e)));


  //error handling on future list
extension EmptyOnError<E> on Future<List<Iterable<E>>> {
  Future<List<Iterable<E>>> emptyOnError() => catchError(
    (_,__)=> List<Iterable<E>>.empty()
  );
  }
  //error handling on per future
  extension EmptyOnErrorOnFuture<E> on Future<Iterable<E>> {
  Future<Iterable<E>> emptyOnError() => catchError(
    (_,__)=> Iterable<E>.empty()
  );
  }
void testIt() async {

 final result = Future.forEach(
  Iterable.generate(
    2,
    (i)=> 'http://127.0.0.1:5500/apis/people${i+1}.json'
  ), 
  parseJson // auto pass url argument to this function
  ).catchError((_,__)=>-1);  // if successful, return null

  if (result != null) {
    'Error occured'.log();
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
        body: TextButton(onPressed: () {
          testIt();
        }, child: const Text('Press me'))
      ),
    );
  }
}