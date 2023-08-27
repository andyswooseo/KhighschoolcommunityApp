import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/pages/login.dart';
import 'package:schoolapp/pages/onboarding_page.dart';
import 'package:schoolapp/pages/register.dart';
import 'package:schoolapp/pages/screenbar.dart';
import 'package:schoolapp/services/auth/auth_service.dart';
import 'package:schoolapp/services/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
