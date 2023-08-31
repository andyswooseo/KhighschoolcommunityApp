import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providerclass/allprovider.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //add a new document for a the user in users collection if it doesn't already exists
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      }, SetOptions(merge: true));

      return userCredential;
    }

    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create a new user
  Future<UserCredential> signUpWithEmailPassword(email, password, nickname) async {
    try {
      UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //after creating the user, craete a new document for the user in the users collection
      _firestore.collection('users').doc(email).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
        'nickname' : nickname,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign user out
  Future<void> signOut(BuildContext context) async {
    //로그아웃시 schoolcontroller 초기화
    Provider.of<SchoolControllerProvider>(context, listen: false).resetSchoolValue();
    return await FirebaseAuth.instance.signOut();
  }
}