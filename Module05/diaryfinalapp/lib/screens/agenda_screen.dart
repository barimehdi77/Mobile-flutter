import 'package:diaryapp/widgets/background_painter_widget.dart';
import 'package:diaryapp/widgets/display_agenda_widget.dart';
import 'package:diaryapp/widgets/list_container_widget.dart';
import 'package:flutter/material.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agenda",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(46, 86, 180, 1),
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: BackgroundPainterWidget(),
            size: Size.infinite,
          ),
          const ListContainerWidget(
            width: 0,
            height: 0,
            margin: EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
              bottom: 30,
            ),
            padding: EdgeInsets.all(10),
            child: DisplayAgendaWidget(),
          ),
        ],
      ),
    );
  }
}
