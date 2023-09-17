import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utility/utils.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  Future<DocumentSnapshot> getDocument() async {
    var firebaseUser =
        await FirebaseAuth.instance.currentUser!.email.toString();
    return FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  FutureBuilder(
                      future: getDocument(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            snapshot.data!["schoolvalue"].toString(),
                            style: SafeGoogleFont(
                              'Noto Sans KR',
                              fontSize: 30,
                              fontWeight: FontWeight.w100,
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return Text("error ??");
                        }
                        return CircularProgressIndicator();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
