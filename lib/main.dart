import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp/ui/pages/detail.dart';
import 'ui/pages/home.dart';
import 'package:go_router/go_router.dart';


void main(){
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: GoRouter(
          routes: [
            GoRoute(path: '/',
            builder: (context, state) {
              return Home();
            },),
            GoRoute(path: '/name/:name',
            builder: (context, state) {
              String? name = state.pathParameters['name']?? '';
              return Detail(name: name);
            },),
          ]
        ),
      ),
    );
  }
}
