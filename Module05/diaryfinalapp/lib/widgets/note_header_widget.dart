import 'package:diaryapp/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoteHeaderWidget extends StatelessWidget {
  const NoteHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNote =
        Provider.of<NotesProvider>(context, listen: true).getSelectedNote;

    if (selectedNote == null) return Container();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                selectedNote.date[0],
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(46, 86, 180, 1),
                ),
              ),
              Text(
                selectedNote.date[1],
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(46, 86, 180, 1),
                ),
              ),
              Text(
                selectedNote.date[2],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FittedBox(
            child: Column(
              children: [
                Lottie.asset(
                  "assets/lotties/${selectedNote.feeling.toLowerCase()}.json",
                ),
                Text(
                  selectedNote.feeling,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(46, 86, 180, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
