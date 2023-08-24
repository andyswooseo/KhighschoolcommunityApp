import 'package:flutter/material.dart';
import 'package:schoolapp/components/scrollablecolumn.dart';
import 'package:schoolapp/components/text_field.dart';

import '../utility/utils.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                  SizedBox(
                    height: mHeight * 0.1
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 64*fem,
                        decoration: BoxDecoration (
                          color: Color(0xff000000),
                        ),
                        child: Center(
                          child: Text(
                            '다음',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'Noto Sans KR',
                              fontSize: 20*ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.3*ffem/fem,
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
