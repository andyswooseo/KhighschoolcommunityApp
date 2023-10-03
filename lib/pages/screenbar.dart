import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/components/scrollablecolumn.dart';
import 'package:schoolapp/providerclass/allprovider.dart';
import 'package:schoolapp/utility/utils.dart';

class SchoolSelection extends StatefulWidget {

  const SchoolSelection({super.key});

  @override
  State<SchoolSelection> createState() => _SchoolSelectionState();
}

class _SchoolSelectionState extends State<SchoolSelection> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedRegion;
  List<String> allSchoolValue = [];
  TextEditingController schoolcontroller = TextEditingController();

  Future<void> fetchAllSchoolValue() async {
    if (selectedRegion != null) {
      final snapshot =
          await _firestore.collection('schoolname').doc(selectedRegion).get();
      if (snapshot.exists) {
        setState(() {
          allSchoolValue = (snapshot['allschool'] as List<dynamic>)
              .map<String>((item) => item.toString())
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 441;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: ScrollableColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: mHeight * 0.1),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '어디 학교 다님 ?',
                style: SafeGoogleFont(
                  'Noto Sans KR',
                  fontSize: 30 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.25 * ffem / fem,
                  color: const Color(0xff000000),
                ),
              ),
            ),
          ),
          SizedBox(height: mHeight * 0.1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '1. 학교 시도교육청 선택하기',
              style: SafeGoogleFont(
                'Noto Sans KR',
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.3 * ffem / fem,
                color: const Color(0xff000000),
              ),
            ),
          ),
          SizedBox(
            height: 8.5 * fem,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 10))
                ]),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('schoolname').snapshots(),
              builder: (context, snapshot) {
                List<DropdownMenuItem> regionItems = [];
                if (!snapshot.hasData) {
                  const CircularProgressIndicator();
                } else {
                  final regions = snapshot.data?.docs.reversed.toList();
                  for (var region in regions!) {
                    regionItems.add(
                      DropdownMenuItem(
                        value: region.id,
                        child: Text(region["region"]),
                      ),
                    );
                  }
                }
                return DropdownButton(
                  hint: const Text('  학교 시도교육청을 선택해주세요.'),
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: regionItems,
                  value: selectedRegion,
                  onChanged: (regionValue) {
                    setState(() {
                      selectedRegion = regionValue;
                      fetchAllSchoolValue();
                    });
                  },
                  isExpanded: true,
                );
              },
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '2. 재학 중인 고등학교 검색',
              style: SafeGoogleFont(
                'Noto Sans KR',
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.3 * ffem / fem,
                color: const Color(0xff000000),
              ),
            ),
          ),
          SizedBox(
            height: 8.5 * fem,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 10))
                ]),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return allSchoolValue.where((String item) {
                  return item.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selectedValue) {
                setState(() {
                  schoolcontroller.text = selectedValue;
                  Provider.of<SchoolControllerProvider>(context, listen: false).schoolValue = selectedValue;
                });
              },
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              if (schoolcontroller.text.isNotEmpty) {
                Provider.of<NextButtonProvider>(context, listen: false).setClicked(true);
              } else {
                Provider.of<NextButtonProvider>(context, listen: false).setClicked(false);
              }
              FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email.toString()).update({
                'schoolvalue' : schoolcontroller.text
              });
            },
            child: Container(
              width: mWidth,
              height: 64 * fem,
              decoration: const BoxDecoration(
                color: Color(0xff000000),
              ),
              child: Center(
                child: Text(
                  '다음',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Noto Sans KR',
                    fontSize: 20 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3 * ffem / fem,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
