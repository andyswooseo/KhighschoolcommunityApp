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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '우리 학교',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'BMHANNA', fontSize: 30),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    '학교 커뮤니티',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'BMHANNA', fontSize: 30)
                  ),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: TextStyle(
                                      fontFamily: 'BMHANNA', fontSize: 40),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Text("error ??");
                              }
                              return CircularProgressIndicator();
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '2-3 박범진 학생',
                          style: TextStyle(
                              fontFamily: 'BMHANNA',
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
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
              Text(
                '급식 일정표',
                style: TextStyle(fontFamily: 'BMHANNA', fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[500]!,
                                offset: const Offset(2, 2),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-2, -2),
                                  blurRadius: 15,
                                  spreadRadius: 1)
                            ]),
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
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[500]!,
                                offset: const Offset(2, 2),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-2, -2),
                                  blurRadius: 15,
                                  spreadRadius: 1)
                            ]),
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
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[500]!,
                                offset: const Offset(2, 2),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-2, -2),
                                  blurRadius: 15,
                                  spreadRadius: 1)
                            ]),
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
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[500]!,
                                offset: const Offset(2, 2),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-2, -2),
                                  blurRadius: 15,
                                  spreadRadius: 1)
                            ]),
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
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
