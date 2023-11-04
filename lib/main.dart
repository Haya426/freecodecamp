import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:async/async.dart' show StreamGroup;

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

  @override
  String toString() {
    return 'Person (name: $name, age: $age)';
  }
}

@immutable
class  PersonRequest {
  final ReceivePort receivePort;
  final Uri uri;
  const PersonRequest(this.receivePort, this.uri);

  //Iterable ကိုသုံးပြီး instance ၃ ခုဖန်တီးမယ် 
  static Iterable<PersonRequest> all() sync* {
    for (final i in Iterable.generate(3,(i) => i)) {
      yield PersonRequest(ReceivePort(),
      Uri.parse('http://127.0.0.1:5500/apis/people${i+1}.json'));
    }
  }
  
}
@immutable
class Request {
final SendPort sendPort;
final Uri uri;
  const Request(this.sendPort, this.uri);

  Request.from(PersonRequest request) 
  : sendPort = request.receivePort.sendPort,
  uri = request.uri;
}

Stream<Iterable<Person>> getPersons() {
  final streams = PersonRequest
              .all()
              .map((req) => 
              Isolate.spawn(_getPersons,Request.from(req))
              .asStream()
              .asyncExpand((_) => req.receivePort)
              .takeWhile((element) => element is Iterable<Person>)
              .cast())
              ;
  return StreamGroup.merge(streams).cast();
}
void _getPersons(Request request) async {
  final persons = await HttpClient()
  .getUrl(request.uri)
  .then((req) => req.close())
  .then((reponse) => reponse.transform(utf8.decoder).join())
  .then((jsonString) => json.decode(jsonString)as List<dynamic>)
  .then((json) => json.map((map) => Person.fromJson(map)));

  Isolate.exit(request.sendPort,persons);
  // request.sendPort.send(persons);
}


void testIt() async {
  await for (final msg in getPersons()){
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