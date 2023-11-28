import 'package:diaryapp/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DisplayAgendaWidget extends StatefulWidget {
  const DisplayAgendaWidget({super.key});

  @override
  State<DisplayAgendaWidget> createState() => _DisplayAgendaWidgetState();
}

class _DisplayAgendaWidgetState extends State<DisplayAgendaWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final notesList =
        Provider.of<NotesProvider>(context).getAllUserNotes!.where(
      (element) {
        DateFormat format = DateFormat("dd MMM yyyy");
        return element.date.join(' ') == format.format(_selectedDay!);
      },
    ).toList();
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2023, 11, 20),
          lastDay: DateTime.now(),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          weekNumbersVisible: true,
          weekendDays: const [
            DateTime.sunday,
            DateTime.saturday,
          ],
          calendarFormat: CalendarFormat.month,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Provider.of<NotesProvider>(context, listen: false)
                      .setSelectedNote = notesList[index];
                  Navigator.of(context).pop();
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
          ),
        ),
      ],
    );
  }
}
