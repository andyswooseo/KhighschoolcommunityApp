import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/services/auth/auth_service.dart';

class StudyTimer extends StatefulWidget {
  const StudyTimer({super.key});

  @override
  State<StudyTimer> createState() => _StudyTimerState();
}

class _StudyTimerState extends State<StudyTimer> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.email;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(currentUser.toString()),
              ElevatedButton(
                onPressed: () async {
                  try {
                    AuthService authService =
                    Provider.of<AuthService>(context, listen: false);
                    await authService.signOut(context);
                  } catch (e) {
                    print('로그아웃 중 오류');
                  }
                },
                child: Text('로그아웃'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}