import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/date_time_ListDay.dart';

const dayListKey = "list_day";

class ListDayRepository {
  // "late" significa que vai ser inicilizalida no futuro
  late SharedPreferences sharedPreferences;

  // para obter a lista lista reload
  Future<List<Todo>> getListDay() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(dayListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  // para salvar o lista reload
  void saveListDay(List<Todo> tasks) {
    final String jsonString = json.encode(tasks);
    sharedPreferences.setString(dayListKey, jsonString);
  }
}
