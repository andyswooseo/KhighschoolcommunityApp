import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  String? mySchool;

  Future _getSchoolName() async {
    String currentUserEmail =
    FirebaseAuth.instance.currentUser!.email.toString();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserEmail)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          mySchool = snapshot.data()!["schoolvalue"].toString();
          print(mySchool);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getSchoolName().then((schoolName) {
      setState(() {
        mySchool = schoolName;
      });
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ],
            ),
          ),
        ),
      ),
    );
  }
}
