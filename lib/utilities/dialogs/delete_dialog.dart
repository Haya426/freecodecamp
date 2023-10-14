import 'package:flutter/material.dart';
import 'package:freecodecamp/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context){
  return  showGenericDialog<bool>(
    context: context, 
    title: 'Delete', 
    content: 'Are you sure you want to delete item?', 
    optionBuilder: ()=>{
      'Cancel' : false,
      'Yes' : true
    }).then((value) => value?? false);

}