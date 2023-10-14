import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:freecodecamp/services/crud/note_service.dart';
import 'package:freecodecamp/utilities/dialogs/delete_dialog.dart';

// typedef Calculator = int Function(int, int);

// int add(int a, int b) {
//   return a + b;
// }

// int subtract(int a, int b) {
//   return a - b;
// }

// void main() {
//   Calculator myCalculator; // Declare a variable with the custom function type.
  
//   myCalculator = add; // Assign the 'add' function to it.
//   print(myCalculator(5, 3)); // Output: 8
  
//   myCalculator = subtract; // Assign the 'subtract' function to it.
//   print(myCalculator(8, 2)); // Output: 6
// }

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {

  
  final List<DatabaseNote> notes;
  final DeleteNoteCallback onDeleteNote;
  const NotesListView({super.key, required this.notes, required this.onDeleteNote});

  @override
  Widget build(BuildContext context) {
     return ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            final note = notes[index];
                            return ListTile(
                              title: Text(
                                note.text,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  final shouldDelete  = await showDeleteDialog(context);
                                  if(shouldDelete) { 
                                    print(note);
                                    onDeleteNote(note);
                                  }
                                }, 
                                icon: const Icon(Icons.delete)),
                            );
                          },
                        );
  }
}