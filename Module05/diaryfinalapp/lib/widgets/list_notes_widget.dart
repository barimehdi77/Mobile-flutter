import 'package:diaryapp/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ListNotesWidget extends StatelessWidget {
  const ListNotesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notesList = Provider.of<NotesProvider>(context).getAllUserNotes!;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<NotesProvider>(context, listen: false).setSelectedNote =
                notesList[index];
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
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
                notesList[index].content.length > 15
                    ? notesList[index].content.replaceRange(
                          15,
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
          ),
        );
      },
    );
  }
}
