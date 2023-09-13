import 'package:individual/Models/user.dart';

class Access {
  final int id;
  final User from;
  final User to;
  final int studyMaterialId;

  Access(
      {required this.id,
      required this.from,
      required this.to,
      required this.studyMaterialId});
}
