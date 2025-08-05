import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_agus/models/quran_model.dart';

class QuranService {
  static const String postsUrl = 'https://api.npoint.io/99c279bb173a6e28359c/data/';

  static Future<List<QuranModel>> listQuran() async {
    final response = await http.get(Uri.parse(postsUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => QuranModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal Load Data Album');
    }
  }
}
