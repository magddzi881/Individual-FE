import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:individual/Database/quiz_db.dart';
import 'package:individual/Models/question.dart';
import 'package:individual/Models/quiz.dart';
import 'package:individual/Utils/global_vars.dart';

Future<List<Question>> getQuestions(int studyMaterialId) async {
  Quiz quiz = await getQuizByStudyMaterialId(studyMaterialId);
  final response = await http.get(
      Uri.parse('$url/questions/byQuizId/${quiz.id}'),
      headers: getHeaders);

  List<Question> questions = [];
  if (response.statusCode == 200) {
    if (response.statusCode == 200) {
      final List<dynamic> studyMaterialDataList = json.decode(response.body);

      for (final q in studyMaterialDataList) {
        final studyMaterial = Question(
          title: q['title'],
          answer1: q['answer1'],
          answer2: q['answer2'],
          answer3: q['answer3'],
          answer4: q['answer4'],
          correctAnswer: q['correctAnswer'],
          quizId: quiz.id,
          id: q['id'],
        );
        questions.add(studyMaterial);
      }
    }
  } else {}
  return questions;
}

Future<bool> addQuestion(Question question) async {
  bool added = false;

  final Map<String, dynamic> ratingData = {
    'quizId': question.quizId,
    'title': question.title,
    'correctAnswer': question.correctAnswer,
    'answer1': question.answer1,
    'answer2': question.answer2,
    'answer3': question.answer3,
    'answer4': question.answer4,
  };

  final response = await http.post(
    Uri.parse('$url/questions'),
    headers: actionHeaders,
    body: json.encode(ratingData),
  );

  if (response.statusCode == 201) {
    added = true;
  } else {}

  return added;
}

Future<bool> deleteQuestionById(int questionId) async {
  final response = await http.delete(
    Uri.parse('$url/questions/$questionId'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Question> getQuestionById(int id) async {
  final response =
      await http.get(Uri.parse('$url/questions/$id'), headers: getHeaders);

  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);

    final studyMaterial = Question(
      title: data['title'],
      answer1: data['answer1'],
      answer2: data['answer2'],
      answer3: data['answer3'],
      answer4: data['answer4'],
      correctAnswer: data['correctAnswer'],
      quizId: data['quizId'],
      id: data['id'],
    );

    return studyMaterial;
  } else {
    throw Exception();
  }
}

Future deleteQuestionsMaterialId(int studyMaterialId) async {
  List<Question> questions = await getQuestions(studyMaterialId);

  for (int i = 0; i < questions.length; i++) {
    Question question = await getQuestionById(questions[i].id);
    await http.delete(
      Uri.parse('$url/questions/${question.id}'),
      headers: getHeaders,
    );
  }
}
