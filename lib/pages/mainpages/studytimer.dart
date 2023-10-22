import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/services/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:xml/xml.dart';
class StudyTimer extends StatefulWidget {
  const StudyTimer({super.key});

  @override
  State<StudyTimer> createState() => _StudyTimerState();
}

class _StudyTimerState extends State<StudyTimer> {
  String? atpt_ofcdc_sc_code;
  String? sd_schul_code;
  String? schoolName;

  @override
  void initState() {
    super.initState();
    getFirebaseData();
  }

  final currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();

  Future<void> getFirebaseData() async{
    var a = await FirebaseFirestore.instance.collection('users').doc(currentUserEmail).get();
    setState(() {
      schoolName = a['highschool'];
    });
  }

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser!.email;

    Future<DocumentSnapshot> getDocument() async {
      var firebaseUser = await FirebaseAuth.instance.currentUser!.email.toString();
      return FirebaseFirestore.instance.collection("users").doc(firebaseUser).get();
    }

    Future<String> fetchMealInfoFromServer(String a, String b) async {
      // 현재 날짜를 가져옵니다. (예: 20231013 형식)
      DateTime now = DateTime.now();
      String formattedDate = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

      // 수정한 URL을 생성합니다.
      String url = 'https://open.neis.go.kr/hub/mealServiceDietInfo'
          '?ATPT_OFCDC_SC_CODE=$a'
          '&SD_SCHUL_CODE=$b'
          '&MLSV_YMD=$formattedDate';

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          // 요청이 성공하면 응답 데이터를 반환합니다.
          final mealInfoXml = response.body;

          final document = XmlDocument.parse(mealInfoXml);
          final wantDataElement = document.findAllElements('DDISH_NM').first;
          final wantDataText = wantDataElement.text;
          final cleanedText = wantDataText.replaceAll(RegExp(r'<br/>'), '\n').trim();
          
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


    Future<bool> checkFieldExist1() async {
      try {
        // Firestore에서 문서를 가져옵니다.
        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(currentUser.toString()).get();

        // 가져온 문서에서 필드가 존재하는지 확인합니다.
        Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;

        if (dataMap.containsKey('highschool')) {
          return true; // 필드가 존재하는 경우 true를 반환합니다.
        } else {
          return false; // 필드가 존재하지 않는 경우 false를 반환합니다.
        }
      } catch (e) {
        // 에러 처리
        print('에러 발생: $e');
        return false; // 에러가 발생한 경우에도 false를 반환합니다.
      }
    }
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
              ElevatedButton(onPressed: checkFieldExist1, child: Text(checkFieldExist1().toString())),
              Text(schoolName.toString())
        ],
          ),
        ),
      ),
    );
  }
}