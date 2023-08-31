import 'package:flutter/material.dart';

class SchoolControllerProvider with ChangeNotifier {
  TextEditingController _schoolController = TextEditingController();

  String? get schoolValue => _schoolController.text.isEmpty ? null : _schoolController.text;

  set schoolValue(String? newValue) {
    _schoolController.text = newValue ?? '';
    notifyListeners();
  }

  void resetSchoolValue() {
    _schoolController.clear();
    notifyListeners();
  }
}

class NextButtonProvider with ChangeNotifier {
  bool _isClicked = false;

  bool get isClicked => _isClicked;

  void setClicked(bool clicked) {
    _isClicked = clicked;
    notifyListeners();
  }

  void resetClicked() {
    _isClicked = false;
    notifyListeners();
  }
}