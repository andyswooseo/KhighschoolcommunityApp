import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/components/my_button.dart';
import 'package:schoolapp/components/scrollablecolumn.dart';
import 'package:schoolapp/services/auth/auth_service.dart';
import 'package:schoolapp/utility/utils.dart';
import 'package:schoolapp/components/text_field.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();

  //sign in user
  void signIn() async {
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signinWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '계정이 아직 없으신가요 ?',
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
                          '회원가입하기',
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
                  )
                ],
              ),
            ),
            Spacer(),
            MyButton(
              onTap: signIn,
              text: "로그인하기",
            )
          ],
        ),
      ),
    );
  }
}
