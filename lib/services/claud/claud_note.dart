import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freecodecamp/services/claud/cluad_storage_constants.dart';


@immutable
class ClaudNote{
  final String documentId;
  final String ownerUserId;
  final String text;

  const ClaudNote({
    required this.documentId, 
    required this.ownerUserId, 
    required this.text,
});
  ClaudNote.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot):
  documentId = snapshot.id,
  ownerUserId = snapshot.data()[ownerUserIdFieldName],
  text = snapshot.data()[textFieldName] as String
  ;
  
}