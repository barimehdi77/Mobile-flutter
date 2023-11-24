import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/providers/storage_service_provider.dart';
import 'package:diaryapp/providers/user_provider.dart';
import 'package:diaryapp/widgets/create_new_note_widget.dart';
import 'package:diaryapp/widgets/display_error_message_widget.dart';
import 'package:diaryapp/widgets/list_notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesStreamWidget extends StatefulWidget {
  const NotesStreamWidget({super.key});

  @override
  State<NotesStreamWidget> createState() => _NotesStreamWidgetState();
}

class _NotesStreamWidgetState extends State<NotesStreamWidget> {
  String? selectedFeeling;
  bool isCreateNewNote = false;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    final userModel = Provider.of<UserProvider>(context);
    Stream<QuerySnapshot<Object?>> getAllNotes;

    if (userModel.getUser == null) return Container();

    getAllNotes =
        notes.where("email", isEqualTo: userModel.getUser!.email).snapshots();

    Future<void> postNewNote() async {
      await notes.add({
        "email": userModel.getUser!.email,
        "title": _titleEditingController.value.text,
        "content": _contentEditingController.value.text,
        "feeling": selectedFeeling,
        "date": Timestamp.now(),
      });
      setState(() {
        isCreateNewNote = false;
        selectedFeeling = null;
        _contentEditingController.clear();
        _titleEditingController.clear();
      });
    }

    return StreamBuilder(
      stream: getAllNotes,
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

        if (isCreateNewNote) {
          return CreateNewNoteWidget(
            selectedFeeling: selectedFeeling,
            onClose: () {
              setState(() {
                isCreateNewNote = false;
                selectedFeeling = null;
                _contentEditingController.clear();
                _titleEditingController.clear();
              });
            },
            onSelectFeeling: (String feeling) {
              setState(() {
                selectedFeeling = feeling;
              });
            },
            titleEditingController: _titleEditingController,
            contentEditingController: _contentEditingController,
            onSubmit: postNewNote,
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListNotesWidget(
              docs: snapshot.data!.docs,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isCreateNewNote = true;
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false).setUser =
                        null;
                    Provider.of<StorageServiceProvider>(context, listen: false)
                        .storageService
                        .deleteAllSecureData();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
//
