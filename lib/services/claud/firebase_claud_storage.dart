import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freecodecamp/services/claud/claud_note.dart';
import 'package:freecodecamp/services/claud/claud_storage_exception.dart';
import 'package:freecodecamp/services/claud/cluad_storage_constants.dart';

class FirebaseClaudStorage {

  final notes = FirebaseFirestore.instance.collection('notes');

  //The _shared variable is assigned the result of the _sharedInstance constructor.
  // The _shared instance is created when the class is first accessed 
  //and can be accessed via the factory constructor.

  static final FirebaseClaudStorage _shared =
               FirebaseClaudStorage._sharedInstance();
  FirebaseClaudStorage._sharedInstance();
  factory FirebaseClaudStorage() => _shared;

  Future<ClaudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName : ownerUserId,
      textFieldName : '',
    });
    final fetchedNote = await document.get();
    return ClaudNote(
      documentId: fetchedNote.id, 
      ownerUserId: ownerUserId, 
      text: '',
       );
  }
  //delte note
  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }
 // update note
  Future<void> updateNote({
    required String documentId,
    required String text
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName:text});
    } catch (e){
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<ClaudNote>> allNotes({required String ownerUserId}) =>
  notes.snapshots().map((event) => event.docs
  .map((doc) => ClaudNote.fromSnapshot(doc))
  .where((note) => note.ownerUserId == ownerUserId)); 
  Future<Iterable<ClaudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes.where(
        ownerUserIdFieldName,
        isEqualTo: ownerUserId 
      ).get()
       .then((value) => value.docs.map((doc)
       => ClaudNote.fromSnapshot(doc)))
      ;
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }


}