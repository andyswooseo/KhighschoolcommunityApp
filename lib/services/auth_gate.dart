import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/pages/mainpages/bottomnav.dart';
import 'package:schoolapp/pages/screenbar.dart';
import '../providerclass/allprovider.dart';
import 'auth/login_or_register.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  @override
  Widget build(BuildContext context) {

    final schoolControllerProvider = Provider.of<SchoolControllerProvider>(context);
    final nextButtonProvider = Provider.of<NextButtonProvider>(context);
    bool isButtonClicked = nextButtonProvider.isClicked;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (schoolControllerProvider.schoolValue != null && isButtonClicked) {
              return BottomNav();
            }
            else {
              return SchoolSelection();
            }
          }
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
