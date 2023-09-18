import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
        backgroundColor: Color(0xFFE7E7E7),
        body: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: getDocument(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  snapshot.data!["schoolvalue"].toString(),
                                  style: SafeGoogleFont(
                                    'Noto Sans KR',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                  ),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Text("error ??");
                              }
                              return CircularProgressIndicator();
                            }),
                        Text(
                          '2-3 박범진 학생',
                          style: SafeGoogleFont(
                            'Noto Sans KR',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '중간고사',
                              style: SafeGoogleFont(
                                'Noto Sans KR',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('D-DAY'),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Text(
                              '6월 모고',
                              style: SafeGoogleFont(
                                'Noto Sans KR',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('D-6'),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: -10,
                      shadowLightColor: Colors.white
                    ),
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '오늘의 급식 ??',
                                style: SafeGoogleFont(
                                  'Noto Sans KR',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '현미밥 \n맛있는 김 \n김치 \n호두과자 \n야자열매',
                                style: SafeGoogleFont(
                                  'Noto Sans KR',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '오늘의 할 일을 완성해주세요.',
                              style: SafeGoogleFont(
                                'Noto Sans KR',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('1. 모의고사 문제 10개 풀기'),
                            Text('2. 영어 단어 40개 외우기'),
                            Text('3. 한국사 페이지 10~40 페이지 외우기'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
