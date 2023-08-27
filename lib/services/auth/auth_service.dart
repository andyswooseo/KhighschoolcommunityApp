import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign user in
  Future<UserCredential> signinWithEmailandPassword(String email,
      String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create a new user
  Future<UserCredential> signUpWithEmailandPasswordandNickname(String email,
      password, nickname) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Update the user's nickname in Firebase
      await userCredential.user!.updateDisplayName(nickname);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  //sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}

class SchoolService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSchool(String region, String schoolName) async {
    try {
      await _firestore.collection('schools').add({
        'region': region,
        'schoolName': schoolName,
        // 여기에 추가 정보를 필요에 따라 추가합니다.
      });
    } catch (e) {
      print("Error adding school: $e");
      // 오류 처리
    }
  }
}