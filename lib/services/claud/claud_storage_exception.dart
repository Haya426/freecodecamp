class ClaudStorageException implements Exception {
  const ClaudStorageException();
}
// C in Crud
class CouldNotCreateNoteException extends ClaudStorageException {}
//R in Crud
class CouldNotGetAllNotesException extends ClaudStorageException {}
// U in Crud
class CouldNotUpdateNoteException extends ClaudStorageException{}
// D in Crud
class CouldNotDeleteNoteException extends ClaudStorageException {}