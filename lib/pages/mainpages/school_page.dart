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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
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
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    '급식 일정표',
                    style: TextStyle(fontFamily: 'BMHANNA', fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 150,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                        child: Center(
                          child: Text('월요일'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 100,
                        height: 150,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                        child: Center(
                          child: Text('화요일'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 100,
                        height: 150,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                        child: Center(
                          child: Text('수요일'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 100,
                        height: 150,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                        child: Center(
                          child: Text('목요일'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 100,
                        height: 150,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                        child: Center(
                          child: Text('금요일'),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
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
            )
          ],
        ),
      ),
    );
  }
}