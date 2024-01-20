import 'package:diaryapp/models/notes_model.dart';
import 'package:diaryapp/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ListNotesWidget extends StatelessWidget {
  const ListNotesWidget({
    super.key,
    this.selectedDate,
    this.displayedItems,
  });

  final String? selectedDate;
  final int? displayedItems;

  @override
  Widget build(BuildContext context) {
    final List<NotesModel> notesList;
    if (selectedDate != null) {
      notesList = Provider.of<NotesProvider>(context)
          .getAllUserNotes!
          .where((element) => element.date.join('-') == selectedDate)
          .toList();
    } else {
      notesList = Provider.of<NotesProvider>(context).getAllUserNotes!;
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: notesList.length > 2 ? displayedItems : notesList.length,
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
                notesList[index].title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                notesList[index].content,
                overflow: TextOverflow.ellipsis,
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
