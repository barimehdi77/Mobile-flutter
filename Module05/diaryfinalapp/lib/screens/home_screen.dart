import 'package:diaryapp/providers/notes_provider.dart';
import 'package:diaryapp/widgets/background_painter_widget.dart';
import 'package:diaryapp/widgets/display_profile_widget.dart';
import 'package:diaryapp/widgets/display_selected_note_widget.dart';
import 'package:diaryapp/widgets/list_container_widget.dart';
import 'package:diaryapp/widgets/notes_stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNote =
        Provider.of<NotesProvider>(context, listen: true).getSelectedNote;

    return Scaffold(
      body: Stack(
        children: [
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
                      : const DisplaySelectedNoteWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
