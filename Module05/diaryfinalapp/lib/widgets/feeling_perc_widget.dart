import 'package:diaryapp/enums/feelings_enum.dart';
import 'package:diaryapp/models/notes_model.dart';
import 'package:diaryapp/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FeelingPercWidget extends StatelessWidget {
  const FeelingPercWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context).getAllUserNotes;
    if (notes == null) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Your feel % is: ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ...FeelingsEnum.values.map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      "assets/lotties/${e.name.toLowerCase()}.json",
                    ),
                  ),
                  Text(
                    "${((notes.where((note) => note.feeling == e.name).length * 100) / notes.length).toStringAsFixed(0)}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
