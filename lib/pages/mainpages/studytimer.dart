import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/services/auth/auth_service.dart';

import '../../services/auth/uservalueprovider.dart';

class StudyTimer extends StatefulWidget {
  const StudyTimer({super.key});

  @override
  State<StudyTimer> createState() => _StudyTimerState();
}

class _StudyTimerState extends State<StudyTimer> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserValueProvider>(context);
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
              Text('User Email: ${userProvider.userEmail ?? 'N/A'}'),
              Text('Nickname: ${userProvider.nickname ?? 'N/A'}'),
              Text('School Value: ${userProvider.schoolValue ?? 'N/A'}'),
              Text('UID: ${userProvider.uid ?? 'N/A'}'),
            ],
          ),
        ),
      ),
    );
  }
}
