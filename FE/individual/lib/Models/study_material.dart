import 'package:individual/Models/user.dart';

class StudyMaterial {
  final int id;
  final String text;
  final User tutor;
  final String category;

  StudyMaterial({
    required this.id,
    required this.category,
    required this.text,
    required this.tutor,
  });
}
