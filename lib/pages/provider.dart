import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BioProvider extends ChangeNotifier {
  String? _image;
  String? get image => _image;
  double _score = 0;
  double get score => _score;
  String _name = '';
  String get name => _name;

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void setScore(double value) {
    _score = value;
    notifyListeners();
  }

  void setImage(String? value) {
    _image = value;
    notifyListeners();
  }

  void saveBio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name);
  }

  BioProvider() {
    _loadNameFromSharedPreferences();
  }

  _loadNameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? '';
    notifyListeners();
  }
}
