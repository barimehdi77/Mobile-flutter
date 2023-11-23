import 'package:diaryapp/providers/notes_provider.dart';
import 'package:diaryapp/widgets/background_painter_widget.dart';
import 'package:diaryapp/widgets/display_profile_widget.dart';
import 'package:diaryapp/widgets/list_container_widget.dart';
import 'package:diaryapp/widgets/note_header_widget.dart';
import 'package:diaryapp/widgets/notes_stream_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    // final storageService =
    //     Provider.of<StorageServiceProvider>(context, listen: false)
    //         .storageService;
    // final userModel = Provider.of<UserProvider>(context, listen: true);

    final selectedNote =
        Provider.of<NotesProvider>(context, listen: true).getSelectedNote;

    return Scaffold(
      body: Stack(children: [
        CustomPaint(
          painter: BackgroundPainterWidget(),
          size: Size.infinite,
        ),
        SafeArea(
          child: Column(
            children: [
              const DisplayProfileWidget(),
              ListContainerWidget(
                child: selectedNote == null
                    ? const NotesStreamWidget()
                    : Column(
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<NotesProvider>(context,
                                                listen: false)
                                            .setSelectedNote = null;
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<NotesProvider>(context,
                                                listen: false)
                                            .setSelectedNote = null;
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
                      ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
