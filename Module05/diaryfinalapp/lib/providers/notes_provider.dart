import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesProvider with ChangeNotifier {
  NotesModel? selctedNote;
  List<NotesModel>? allUserNotes;

  List<NotesModel>? get getAllUserNotes => allUserNotes;

  set setUserNotes(List<QueryDocumentSnapshot<Object?>>? docs) {
    if (docs == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return;
    }
    DateFormat format = DateFormat("dd MMM yyyy");
    allUserNotes = docs
        .map(
          (note) => NotesModel(
            id: note.id,
            email: note['email'],
            feeling: note['feeling'],
            content: note['content'],
            title: note['title'],
            date:
                format.format((note['date'] as Timestamp).toDate()).split(' '),
          ),
        )
        .toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  NotesModel? get getSelectedNote => selctedNote;
  set setSelectedNote(NotesModel? noteId) {
    selctedNote = noteId;
    notifyListeners();
  }
}
