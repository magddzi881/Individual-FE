import 'dart:convert';

import 'package:individual/Database/access_db.dart';
import 'package:individual/Database/user_db.dart';
import 'package:individual/Models/study_material.dart';
import 'package:individual/Models/user.dart';
import 'package:individual/Utils/global_vars.dart';
import 'package:http/http.dart' as http;

Future<List<StudyMaterial>> getUserAccessibleMaterials(String username) async {
  List<int> ids = await getStudyMaterialIdsByToUser(username);

  final response = await http.post(Uri.parse('$url/study-materials/by-ids'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(ids));
  List<StudyMaterial> studyMaterials = [];

  if (response.statusCode == 200) {
    final List<dynamic> studyMaterialDataList = json.decode(response.body);

    for (final studyMaterialData in studyMaterialDataList) {
      User tutor = await getUser(studyMaterialData['tutorUsername']);
      final studyMaterial = StudyMaterial(
        id: studyMaterialData['id'],
        category: studyMaterialData['category'],
        text: studyMaterialData['text'],
        tutor: tutor,
      );
      studyMaterials.add(studyMaterial);
    }
  } else {}
  return studyMaterials;
}

Future<List<StudyMaterial>> getSharedMaterials(String username) async {
  final response = await http.get(
    Uri.parse('$url/study-materials/by-tutor/$username'),
    headers: getHeaders,
  );
  List<StudyMaterial> studyMaterials = [];

  if (response.statusCode == 200) {
    final List<dynamic> studyMaterialDataList = json.decode(response.body);

    for (final studyMaterialData in studyMaterialDataList) {
      User tutor = await getUser(username);
      final studyMaterial = StudyMaterial(
        id: studyMaterialData['id'],
        category: studyMaterialData['category'],
        text: studyMaterialData['text'],
        tutor: tutor,
      );
      studyMaterials.add(studyMaterial);
    }
  } else {}
  return studyMaterials;
}

Future<bool> addStudyMaterial(StudyMaterial studyMaterial) async {
  bool added = false;

  final Map<String, dynamic> ratingData = {
    'tutorUsername': studyMaterial.tutor.username,
    'text': studyMaterial.text,
    'category': studyMaterial.category,
  };

  final response = await http.post(
    Uri.parse('$url/study-materials'),
    headers: actionHeaders,
    body: json.encode(ratingData),
  );

  if (response.statusCode == 201) {
    added = true;
  } else {}

  return added;
}

Future<StudyMaterial> getStudyMaterialById(int studyMaterialId) async {
  final response = await http.get(
      Uri.parse('$url/study-materials/$studyMaterialId'),
      headers: getHeaders);
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    User tutor = await getUser(data['tutorUsername']);
    StudyMaterial studyMaterial = StudyMaterial(
        id: data["id"],
        category: data["category"],
        text: data["text"],
        tutor: tutor);

    return studyMaterial;
  } else {
    throw Exception();
  }
}

Future<bool> editMaterial(StudyMaterial studyMaterial) async {
  final Map<String, dynamic> userData = {
    'tutorUsername': studyMaterial.tutor.username,
    'text': studyMaterial.text,
    'category': studyMaterial.category,
  };
  final response = await http.put(
    Uri.parse('$url/study-materials/${studyMaterial.id}'),
    headers: actionHeaders,
    body: json.encode(userData),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteStudyMaterialById(int materialId) async {
  final response = await http.delete(
    Uri.parse('$url/study-materials/$materialId'),
    headers: getHeaders,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
