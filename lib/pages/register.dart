import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/components/scrollablecolumn.dart';
import 'package:schoolapp/components/text_field.dart';
import 'package:schoolapp/services/auth/auth_service.dart';
import '../providerclass/allprovider.dart';
import '../utility/utils.dart';
import 'mainpages/bottomnav.dart';

class Register extends StatefulWidget {
  final void Function()? onTap;

  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();
  final schoolcontroller = TextEditingController();

  //sign up user
  void signUp(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('비밀번호가 일치하지 않습니다.'),
        ),
      );
      return;
    }

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        nicknameController.text.isEmpty ||
        schoolcontroller.text.isEmpty ||
        selectedRegion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('모든 필수 필드를 입력하세요.'),
        ),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
          nicknameController.text,
          schoolcontroller.text);

      // 회원가입이 성공하면 BottomNav 화면으로 이동
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomNav(),
        ),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        // Firebase에서 이미 있는 사용자일 경우의 처리
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('이미 존재하는 이메일 주소입니다. 다른 이메일을 시도하세요.'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('비밀번호를 다시 적거나 이메일을 검토해주세요.ㅇ'),
          ),
        );
      }
    }
  }



  //school selection
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedRegion;
  List<String> allSchoolValue = [];

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
    double mHeight = MediaQuery.sizeOf(context).height;

    double baseWidth = 441;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SafeArea(
      child: Scaffold(
        body: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mHeight * 0.05),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  '회원가입',
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
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Container(
                    // 8UZ (1:52)
                    width: MediaQuery.sizeOf(context).width - 50,
                    child: Text(
                      '이메일 *',
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
                  MyTextField(
                    controller: emailController,
                    hintText: '예) abc@gmail.com',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20 * fem,
                  ),
                  Container(
                    // 8UZ (1:52)
                    width: MediaQuery.sizeOf(context).width - 50,
                    child: Text(
                      '비밀번호 *',
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
                  MyTextField(
                    controller: passwordController,
                    hintText: '예) 영문, 숫자, 조합 8~16자',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20 * fem,
                  ),
                  Container(
                    // 8UZ (1:52)
                    width: MediaQuery.sizeOf(context).width - 50,
                    child: Text(
                      '비밀번호 확인 *',
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
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: '비밀번호를 한번 더 입력해주세요.',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20 * fem,
                  ),
                  Container(
                    // 8UZ (1:52)
                    width: MediaQuery.sizeOf(context).width - 50,
                    child: Text(
                      '이름 *',
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
                  MyTextField(
                    controller: nicknameController,
                    hintText: '예) 박범진',
                    obscureText: false,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '학교 시도교육청 선택하기 *',
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
                  border: Border.all(
                    color: Color(0xffaeaeae),
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
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
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '재학 중인 고등학교 검색 *',
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
                    width: 8,
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email.toString()).update({
                        'highschool' : schoolcontroller.text
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('학교 확인'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.5 * fem,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffaeaeae),
                  ),
                  borderRadius: BorderRadius.circular(5)),
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
                    Provider.of<SchoolControllerProvider>(context,
                            listen: false)
                        .schoolValue = selectedValue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 3 * fem,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '혹시 이미 계정이 이미 있으신가요 ?',
                  style: SafeGoogleFont(
                    'Noto Sans KR',
                    fontSize: 13 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.3 * ffem / fem,
                    color: const Color(0xff000000),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    '로그인하기',
                    style: SafeGoogleFont(
                      'Noto Sans KR',
                      fontSize: 13 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                signUp(context);
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 64 * fem,
                decoration: BoxDecoration(
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
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
