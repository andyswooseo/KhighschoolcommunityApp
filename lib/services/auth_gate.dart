import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schoolapp/pages/mainpages/bottomnav.dart';
import 'auth/login_or_register.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool isFieldExist = false;
  final currentUser = FirebaseAuth.instance.currentUser?.email;
  late Stream<DocumentSnapshot> schoolValueStream;

  @override
  void initState() {
    super.initState();
    schoolValueStream = FirebaseFirestore.instance.collection('users').doc(currentUser.toString()).snapshots();
    schoolValueStream.listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;
        bool hasSchoolValue = dataMap.containsKey('highschool');
        setState(() {
          isFieldExist = hasSchoolValue;
          print(isFieldExist);
          print('hello');
        });
      }
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
              return BottomNav();
          }
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}