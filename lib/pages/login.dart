import 'package:flutter/material.dart';
import 'package:schoolapp/components/scrollablecolumn.dart';
import 'package:schoolapp/utility/utils.dart';
import 'package:schoolapp/components/text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final nicknameController = TextEditingController();

    double mHeight = MediaQuery.sizeOf(context).height;

    double baseWidth = 441;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SafeArea(
      child: Scaffold(
        body: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mHeight * 0.2,
                  ),
                  Text(
                    '로그인',
                    style: SafeGoogleFont(
                      'Noto Sans KR',
                      fontSize: 32 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '다시 오신 것을 환영해요 !',
                    style: SafeGoogleFont(
                      'Noto Sans KR',
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1 * ffem / fem,
                      color: const Color(0xffaeaeae),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    '이메일 *',
                    style: SafeGoogleFont(
                      'Noto Sans KR',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    height: 8.5 * fem,
                  ),
                  MyTextField(
                    controller: emailController,
                    hintText: '이메일을 입력하세요.',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20 * fem,
                  ),
                  Text(
                    '비밀번호 *',
                    style: SafeGoogleFont(
                      'Noto Sans KR',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    height: 8.5 * fem,
                  ),
                  MyTextField(
                    controller: passwordController,
                    hintText: '비밀번호를 입력하세요',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '혹시 이미 계정이 이미 있으신가요 ?',
                        style: SafeGoogleFont(
                          'Noto Sans KR',
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.3 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 64*fem,
                decoration: const BoxDecoration (
                  color: Color(0xff000000),
                ),
                child: Center(
                  child: Center(
                    child: Text(
                      '다음',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont (
                        'Noto Sans KR',
                        fontSize: 20*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3*ffem/fem,
                        color: const Color(0xffffffff),
                      ),
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
