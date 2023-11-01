import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

//Mixins together with extensions are very powerful

extension GetOnUri on Object {
  Future<HttpClientResponse> getUrl(String url) 
  =>HttpClient()
  .getUrl(Uri.parse(url))
  .then((req) => req.close());

}

mixin CanMakeGetCall {
  String get url;
  
  @useResult
  Future<String> getString()=>
  getUrl(url)
  .then((res) => res.transform(utf8.decoder).join());
}

@immutable
class GetPeople with CanMakeGetCall {

  
  @override
 
  String get url => 'http://127.0.0.1:5500/api/people.json';
  
}
//to test
void testIt() async{
final people = await  GetPeople().getString();
people.log();
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