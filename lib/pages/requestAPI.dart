import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:musicapps/models/trackModel.dart';

class HttpHelper {
  Future<List<Music>> getData() async {
    final response = await http
        .get(Uri.parse('https://storage.googleapis.com/uamp/catalog.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      Iterable musicList = jsonResponse['music'];

      return musicList.map((data) => Music.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
