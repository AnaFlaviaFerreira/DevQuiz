import 'dart:convert';

import 'package:dev_quiz/shared/models/quiz_model.dart';
import 'package:dev_quiz/shared/models/user_model.dart';
import 'package:flutter/services.dart';

class HomeRepository {
  //acesso o json e retorno os dados
  Future<UserModel> getUser() async {
    final response = await rootBundle.loadString("assets/database/user.json");
    final user = UserModel.fromJson(response);
    return user;
  }

  Future<List<QuizModel>> getQuizzes() async {
    final response = await rootBundle.loadString("assets/database/quizzes.json");
    final list = jsonDecode(response) as List;//recebendo uma lista
    final quizzes = list.map((e) => QuizModel.fromMap(e)).toList();//mapeando a lista
    return quizzes;
  }
}