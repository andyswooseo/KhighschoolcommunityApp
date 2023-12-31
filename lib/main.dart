import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/providerclass/allprovider.dart';
import 'package:schoolapp/services/auth/auth_service.dart';
import 'package:schoolapp/services/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
      ChangeNotifierProvider<SchoolControllerProvider>(create: (_) => SchoolControllerProvider()),
    ],
    child: const MyApp(),
  ));
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
