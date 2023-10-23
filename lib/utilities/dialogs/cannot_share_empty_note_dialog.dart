import 'package:flutter/material.dart';
import 'package:freecodecamp/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context){
  return showGenericDialog(
    context: context, 
    title: 'Sharing', 
    content: 'You can not share empty note!', 
    optionBuilder: ()=>{
      'Ok':null,
    });
}