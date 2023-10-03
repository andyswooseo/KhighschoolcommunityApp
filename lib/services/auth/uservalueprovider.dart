import 'package:flutter/material.dart';

class UserValueProvider with ChangeNotifier {
  String? userEmail;
  String? nickname;
  String? schoolValue;
  String? uid;

  void setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  void setNickname(String userNickname) {
    nickname = userNickname;
    notifyListeners();
  }

  void setSchoolValue(String school) {
    schoolValue = school;
    notifyListeners();
  }

  void setUid(String userUid) {
    uid = userUid;
    notifyListeners();
  }
}
