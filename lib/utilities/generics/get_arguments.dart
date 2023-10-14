import 'package:flutter/material.dart' show BuildContext,ModalRoute;


//  Extensions allow you to add new functionality or methods to existing classes without modifying the original class definition.
extension GetArgument on BuildContext{
  T? getArgument<T>(){
    final modalRoute = ModalRoute.of(this);
    if(modalRoute != null){
      //The settings property contains information about the route, including the arguments passed when navigating to the route.
      final args = modalRoute.settings.arguments;
      if(args != null && args is T){
        return args as T;
      }
    }
    return null;
  }
}