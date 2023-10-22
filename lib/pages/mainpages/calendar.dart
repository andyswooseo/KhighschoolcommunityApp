import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
    did_Change_Dependencies();
  }

  void did_Change_Dependencies() {
    super.didChangeDependencies();
    final dates = getWeekdayStartAndEndDates();
    mondayFormatted = dates[0].toString();
    fridayFormatted = dates[1].toString();
    getFirebaseData();
    getFirebaseData().then((_) {
      calendarUrl =
      'https://open.neis.go.kr/hub/hisTimetable?ATPT_OFCDC_SC_CODE=$atpt_ofcdc_sc_code&SD_SCHUL_CODE=$sd_schul_code&AY=$currentYear&GRADE=2&CLASS_NM=1&TI_FROM_YMD=$mondayFormatted&TI_TO_YMD=$fridayFormatted';
      atpt_ofcdc_sc_code;
      sd_schul_code;
      print(calendarUrl);
      setState(() {}); // Trigger a rebuild after setting calendarUrl
    });
  }

  final currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();
  String? schoolName;
  int currentYear = DateTime.now().year;
  String? mondayFormatted, fridayFormatted;
  String? atpt_ofcdc_sc_code, sd_schul_code;
  String? calendarUrl;
  String? helloworld;

  // 테이블 변수 정리
  String monday1 = ' ';
  String monday2 = ' ';
  String monday3 = ' ';
  String monday4 = ' ';
  String monday5 = ' ';
  String monday6 = ' ';
  String monday7 = ' ';

  String tuesday1 = ' ';
  String tuesday2 = ' ';
  String tuesday3 = ' ';
  String tuesday4 = ' ';
  String tuesday5 = ' ';
  String tuesday6 = ' ';
  String tuesday7 = ' ';

  String wednesday1 = ' ';
  String wednesday2 = ' ';
  String wednesday3 = ' ';
  String wednesday4 = ' ';
  String wednesday5 = ' ';
  String wednesday6 = ' ';
  String wednesday7 = ' ';

  String thursday1 = ' ';
  String thursday2 = ' ';
  String thursday3 = ' ';
  String thursday4 = ' ';
  String thursday5 = ' ';
  String thursday6 = ' ';
  String thursday7 = ' ';

  String friday1 = ' ';
  String friday2 = ' ';
  String friday3 = ' ';
  String friday4 = ' ';
  String friday5 = ' ';
  String friday6 = ' ';
  String friday7 = ' ';


  List<String> getWeekdayStartAndEndDates() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final friday = monday.add(Duration(days: 4));

    final dateFormat = DateFormat('yyyyMMdd');
    final mondayFormatted = dateFormat.format(monday);
    final fridayFormatted = dateFormat.format(friday);

    return [mondayFormatted, fridayFormatted];
  }

  Future<void> getFirebaseData() async {
    var a = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserEmail)
        .get();
    setState(() {
      schoolName = a['highschool'].toString();
    });
    var b = await FirebaseFirestore.instance
        .collection("dataforschoolfood")
        .where("학교명", isEqualTo: schoolName)
        .get();
    if (b.docs.isNotEmpty) {
      final schoolData = b.docs.first.data() as Map<String, dynamic>;
      if (schoolData != null) {
        atpt_ofcdc_sc_code = schoolData['시도교육청코드'].toString();
        sd_schul_code = schoolData['행정표준코드'].toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    List<List<String>> tableData = [
      [monday1, tuesday1, wednesday1, thursday1, friday1],
      [monday2, tuesday2, wednesday2, thursday2, friday2],
      [monday3, tuesday3, wednesday3, thursday3, friday3],
      [monday4, tuesday4, wednesday4, thursday4, friday4],
      [monday5, tuesday5, wednesday5, thursday5, friday5],
      [monday6, tuesday6, wednesday6, thursday6, friday6],
      [monday7, tuesday7, wednesday7, thursday7, friday7],
    ];

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '우리 학교 시간표',
                style: TextStyle(fontFamily: 'BMHANNA', fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Table(
                border: TableBorder.all(color: Colors.black, width: 1.0),
                children: List.generate(
                  7,
                  (rowIndex) => TableRow(
                    children: List.generate(
                      5,
                      (colIndex) => Container(
                        height: 50.0,
                        width: 50.0,
                        alignment: Alignment.center,
                        child: Text(tableData[rowIndex][colIndex]), // 데이터를 추가
                      ),
                    ),
                  ),
                ),
              ),
              Text(mondayFormatted.toString()),
              Text(fridayFormatted.toString()),
              Text(calendarUrl.toString()),
              Text(helloworld.toString()),
              ElevatedButton(onPressed: () {
                print(helloworld.toString());
              }, child: Text('ef'))
            ],
          ),
        ),
      ),
    );
  }
}
