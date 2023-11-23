import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/providers/user_provider.dart';
import 'package:diaryapp/widgets/display_error_message_widget.dart';
import 'package:diaryapp/widgets/list_notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesStreamWidget extends StatelessWidget {
  const NotesStreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    final userModel = Provider.of<UserProvider>(context);

    return StreamBuilder(
      stream:
          notes.where("email", isEqualTo: userModel.getUser!.email).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return DisplayErrorMessageWidget(
            error: "An error ${snapshot.error.toString()}",
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var len = snapshot.data!.docs.length;
        if (len == 0) {
          return const DisplayErrorMessageWidget(
            error: "No notes available",
          );
        }

        return ListNotesWidget(
          docs: snapshot.data!.docs,
        );
      },
    );
  }
}
