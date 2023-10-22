import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

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
    final currentUser = FirebaseAuth.instance.currentUser!.email;

    Future<DocumentSnapshot> getDocument() async {
      var firebaseUser =
          await FirebaseAuth.instance.currentUser!.email.toString();
      return FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser)
          .get();
    }

    Future<String> fetchMealInfoFromServer(String a, String b) async {
      // 현재 날짜를 가져옵니다. (예: 20231013 형식)
      DateTime now = DateTime.now();
      String formattedDate =
          "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

      // 수정한 URL을 생성합니다.
      String url = 'https://open.neis.go.kr/hub/mealServiceDietInfo'
          '?ATPT_OFCDC_SC_CODE=$a'
          '&SD_SCHUL_CODE=$b'
          '&MLSV_YMD=20231013';

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          // 요청이 성공하면 응답 데이터를 반환합니다.
          final mealInfoXml = response.body;
          final document = XmlDocument.parse(mealInfoXml);
          final wantDataElement = document.findAllElements('DDISH_NM').first;
          final wantDataText = wantDataElement.text;
          String cleanedText =
              wantDataText.replaceAllMapped(RegExp(r'\(.*?\)|<br/>'), (match) {
            return '\n';
          }
          );
          return cleanedText;
        } else {
          // 요청이 실패한 경우 null 또는 에러 메시지를 반환합니다.
          return 'failed to fetch meal info';
        }
      } catch (error) {
        // 에러 발생 시 에러 메시지를 반환합니다.
        return 'Error: $error';
      }
    }

    Future<List<String>> fetchAndParseMealInfo(String a, String b) async {
      String cleanedText = await fetchMealInfoFromServer(a, b);
      List<String> mealInfoList = cleanedText.split('\n');
      return mealInfoList;
    }

    DateTime now = DateTime.now();
    int dayOfWeek = now.weekday;
    String? dayName;

    switch (dayOfWeek) {
      case 1:
        dayName = '월요일';
        break;
      case 2:
        dayName = '화요일';
        break;
      case 3:
        dayName = '수요일';
        break;
      case 4:
        dayName = '목요일';
        break;
      case 5:
        dayName = '금요일';
        break;
      case 6:
        dayName = '토요일';
        break;
      case 7:
        dayName = '일요일';
        break;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
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
                  child: Text('학교 커뮤니티',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'BMHANNA', fontSize: 30)),
                ),
              )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
                                      snapshot.data!["highschool"].toString(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '급식 일정표',
                          style: TextStyle(fontFamily: 'BMHANNA', fontSize: 20),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            width: 120,
                            height: 160,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                              child: Center(
                                  child: FutureBuilder(
                                future: getDocument(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot>
                                        userSnapshot) {
                                  if (userSnapshot.connectionState ==
                                      ConnectionState.done) {
                                    final schoolName = userSnapshot.data![
                                        "highschool"]; // Get the user's selected school

                                    return FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection("dataforschoolfood")
                                          .where("학교명", isEqualTo: schoolName)
                                          .get(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              schoolSnapshot) {
                                        if (schoolSnapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (schoolSnapshot
                                              .data!.docs.isNotEmpty) {
                                            final schoolData = schoolSnapshot
                                                .data!.docs.first
                                                .data() as Map<String, dynamic>;

                                            if (schoolData != null) {
                                              final atpt_ofcdc_sc_code =
                                                  schoolData['시도교육청코드']
                                                      .toString();
                                              final sd_schul_code =
                                                  schoolData['행정표준코드'].toString();

                                              return FutureBuilder(
                                                future: fetchAndParseMealInfo(
                                                    atpt_ofcdc_sc_code,
                                                    sd_schul_code),
                                                builder: (context,
                                                    AsyncSnapshot<List<String>>
                                                        mealInfoSnapshot) {
                                                  if (mealInfoSnapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    if (mealInfoSnapshot
                                                        .hasData) {
                                                      if (true != true) {
                                                        return const Text('주말임');
                                                      } else {
                                                        final mealInfoList = mealInfoSnapshot.data;
                                                        return ListView.builder(
                                                          itemCount: mealInfoList?.length ?? 0,
                                                          itemBuilder: (context, index) {
                                                            final text = mealInfoList![index];
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(vertical: 5), // 수직 간격 조절
                                                              child: Text(
                                                                text,
                                                                style: TextStyle(fontSize: 11, height: 0.007),
                                                                overflow: TextOverflow.ellipsis, // 텍스트 오버플로우 방지
                                                                maxLines: 1, // 최대 행 수 (1로 설정하면 한 줄에 표시)
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      return Text(
                                                          'Failed to fetch meal info');
                                                    }
                                                  } else if (mealInfoSnapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator(); // 데이터를 가져오는 동안 로딩 표시
                                                  } else {
                                                    return Text(
                                                        'An error occurred'); // 다른 상태에서 에러 메시지를 표시
                                                  }
                                                },
                                              );
                                            } else {
                                              return Text('School data is null');
                                            }
                                          } else {
                                            return Text(
                                                'School not found in dataforschooldata');
                                          }
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '시간표',
                          style: TextStyle(fontFamily: 'BMHANNA', fontSize: 20),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            width: 120,
                            height: 160,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300),
                            child: Center(
                              child: Text('월요일'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
