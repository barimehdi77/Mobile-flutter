import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/notes_model.dart';
import 'package:diaryapp/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ListNotesWidget extends StatelessWidget {
  const ListNotesWidget({
    super.key,
    required this.docs,
  });

  final List<QueryDocumentSnapshot<Object?>> docs;

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("dd MMM yyyy");
    List<NotesModel> notesList = docs
        .map(
          (note) => NotesModel(
            email: note['email'],
            feeling: note['feeling'],
            content: note['content'],
            title: note['title'],
            date:
                format.format((note['date'] as Timestamp).toDate()).split(' '),
          ),
        )
        .toList();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: notesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<NotesProvider>(context, listen: false).setSelectedNote =
                notesList[index];
          },
          child: ListTile(
            leading: Lottie.asset(
              "assets/lotties/${notesList[index].feeling.toLowerCase()}.json",
            ),
            title: Text(
              notesList[index].title.length > 10
                  ? notesList[index].title.replaceRange(
                        10,
                        notesList[index].title.length,
                        '...',
                      )
                  : notesList[index].title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              notesList[index].content.length > 20
                  ? notesList[index].content.replaceRange(
                        20,
                        notesList[index].content.length,
                        '...',
                      )
                  : notesList[index].content,
            ),
            trailing: Column(
              children: [
                Text(
                  notesList[index].date[0],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  notesList[index].date[1],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(notesList[index].date[2]),
              ],
            ),
          ),
        );
      },
    );
  }
}
