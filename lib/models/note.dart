import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 3)
class Note {
  @HiveField(0)
  String text;
  @HiveField(1)
  String title;

  Note({
    required this.text,
    required this.title,
  });
}
