class NotesModel {
  final String email;
  final String content;
  final String title;
  final List<String> date;
  final String feeling;

  NotesModel({
    required this.email,
    required this.content,
    required this.title,
    required this.date,
    required this.feeling,
  });

  factory NotesModel.fromJson(Map data) {
    return NotesModel(
      email: data['email'],
      content: data['content'],
      title: data['title'],
      date: data['date'],
      feeling: data['feeling'],
    );
  }
}
