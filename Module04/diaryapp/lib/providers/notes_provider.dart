import 'package:diaryapp/models/notes_model.dart';
import 'package:flutter/material.dart';

class NotesProvider with ChangeNotifier {
  NotesModel? selctedNote;

  NotesModel? get getSelectedNote => selctedNote;
  set setSelectedNote(NotesModel? noteId) {
    selctedNote = noteId;
    notifyListeners();
  }
}
