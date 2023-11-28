import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/providers/notes_provider.dart';
import 'package:diaryapp/widgets/note_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplaySelectedNoteWidget extends StatelessWidget {
  const DisplaySelectedNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNote =
        Provider.of<NotesProvider>(context, listen: true).getSelectedNote;
    if (selectedNote == null) return Container();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          child: NoteHeaderWidget(),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedNote.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(
                        46,
                        86,
                        180,
                        1,
                      ),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        selectedNote.content,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<NotesProvider>(context, listen: false)
                          .setSelectedNote = null;
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('notes')
                          .doc(selectedNote.id)
                          .delete();

                      if (context.mounted) {
                        Provider.of<NotesProvider>(context, listen: false)
                            .setSelectedNote = null;
                      }
                    },
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
