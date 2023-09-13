import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/quiz.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/global_vars.dart';

Future<bool> addQuiz(Quiz quiz) async {
  bool added = false;

  final Map<String, dynamic> ratingData = {
    'tutorUsername': quiz.tutorUsername,
    'points': quiz.points,
    'questionCount': quiz.questionCount,
    'studyMaterialId': quiz.studyMaterialId,
  };

  final response = await http.post(
    Uri.parse('$url/quizzes'),
    headers: actionHeaders,
    body: json.encode(ratingData),
  );

  if (response.statusCode == 201) {
    added = true;
  } else {}

  return added;
}

Future<Quiz> getQuizByStudyMaterialId(int studyMaterialId) async {
  Quiz emptyQuiz = Quiz(
      id: -1,
      tutorUsername: 'tutorUsername',
      studyMaterialId: studyMaterialId,
      points: 0,
      questionCount: 0);
  final response = await http.get(
      Uri.parse('$url/quizzes/getQuizByStudyMaterialId/$studyMaterialId'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    if (response.body.isEmpty) {
      return emptyQuiz;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    User tutor = await getUser(data['tutorUsername']);
    Quiz quiz = Quiz(
        id: data["id"],
        points: data["points"],
        questionCount: data["questionCount"],
        studyMaterialId: studyMaterialId,
        tutorUsername: tutor.username);

    return quiz;
  } else {
    return emptyQuiz;
  }
}

Future<bool> editQuiz(Quiz quiz) async {
  final Map<String, dynamic> userData = {
    'tutorUsername': quiz.tutorUsername,
    'points': quiz.points,
    'questionCount': quiz.questionCount,
    'studyMaterialId': quiz.studyMaterialId,
  };
  final response = await http.put(
    Uri.parse('$url/quizzes/${quiz.id}'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteQuizByMaterialId(int materialId) async {
  Quiz quiz = await getQuizByStudyMaterialId(materialId);
  final response = await http.delete(
    Uri.parse('$url/quizzes/${quiz.id}'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
