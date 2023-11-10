import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

//use future.wait() if you want result
//use future.forEach() if you don't care about result

extension Log on Object {
  void log() => devtools.log(toString());
}

const names = [
  'Phong',
  'Dee',
  'Jhon',
  'Sin'
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class UpperCaseSink implements EventSink<String> {
  final EventSink<String> _sink;

  const UpperCaseSink(this._sink);

  @override
  void add(String event) => _sink.add(event.toUpperCase());

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      _sink.addError(error, stackTrace);

  @override
  void close() => _sink.close();
}

class StreamTransformerUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) =>
      Stream<String>.eventTransformed(stream, (sink) => UpperCaseSink(sink));
}

void testIt() async {
  await for (final name in Stream.periodic(
          const Duration(seconds: 1), (_) => names.getRandomElement())
      .transform(StreamTransformerUpperCase())) {
    name.log();
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
          body: TextButton(
              onPressed: () {
                testIt();
              },
              child: const Text('Press me'))),
    );
  }
}
