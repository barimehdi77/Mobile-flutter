import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/enums/feelings_enum.dart';
import 'package:diaryapp/providers/notes_provider.dart';
import 'package:diaryapp/providers/storage_service_provider.dart';
import 'package:diaryapp/providers/user_provider.dart';
import 'package:diaryapp/widgets/create_new_note_widget.dart';
import 'package:diaryapp/widgets/display_error_message_widget.dart';
import 'package:diaryapp/widgets/feeling_perc_widget.dart';
import 'package:diaryapp/widgets/list_notes_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

    getAllNotes = notes
        .where("email", isEqualTo: userModel.getUser!.email)
        .orderBy('date', descending: true)
        .snapshots();

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
          print(snapshot.error);
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
        Provider.of<NotesProvider>(context, listen: false).setUserNotes =
            snapshot.data!.docs;
        if (len == 0) {
          return Column(
            children: [
              const Expanded(
                child: DisplayErrorMessageWidget(
                  error: "No notes available",
                ),
              ),
              pageFooter(),
            ],
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    "Your last Notes are: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ListNotesWidget(),
                ],
              ),
            ),
            const Expanded(child: FeelingPercWidget()),
            pageFooter(),
          ],
        );
      },
    );
  }

  Widget pageFooter() {
    return Row(
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
          onPressed: () async {
            Provider.of<UserProvider>(context, listen: false).setUser = null;
            Provider.of<NotesProvider>(context, listen: false).setUserNotes =
                null;
            await Provider.of<StorageServiceProvider>(context, listen: false)
                .storageService
                .deleteAllSecureData();
            if (context.mounted) {
              Navigator.of(context).pushReplacementNamed('login');
            }
          },
          icon: const Icon(
            Icons.logout_outlined,
            color: Colors.red,
            size: 50,
          ),
        ),
      ],
    );
  }
}
//
