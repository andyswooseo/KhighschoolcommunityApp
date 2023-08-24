import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:schoolapp/pages/login.dart';
import 'package:schoolapp/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _prefsKey = 'showOnBoarding'; // SharedPreferences 키 값
  bool _showOnBoarding = true; // 온보딩 페이지를 보여줄지 여부

  @override
  void initState() {
    super.initState();
    _checkShowOnBoarding();
  }

  void _checkShowOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _showOnBoarding = prefs.getBool(_prefsKey) ?? true;
    });
  }

  void _markOnBoardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_prefsKey, false);
    setState(() {
      _showOnBoarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (!_showOnBoarding) {
      return const Register(); // 이미 온보딩을 완료한 경우 다른 페이지로 이동
    }

    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: '',
            //decoration: PageDecoration(pageColor: Color(0xFFABEB5C),),
            bodyWidget: const Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Text(
                '자신의 고등학교 커뮤니티에서 \n즐겁게 대화해보세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  //fontFamily: 'NanumSquareNeoVariable',
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                ),
              ),
            ),
            image: const Icon(Icons.help),
          ),
          PageViewModel(
              title: '',
              //decoration: PageDecoration(pageColor: Color(0xFFABEB5C)),
              bodyWidget: const Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Text(
                  '전국 고등학생들의 \n익명 커뮤니티도 있어요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //fontFamily: 'NanumSquareNeoVariable',
                    fontWeight: FontWeight.w600,
                    fontSize: 25.0,
                  ),
                ),
              ),
              image: const Icon(Icons.help),
          ),
        ],
        done: const Icon(
              Icons.start,
              color: Colors.black,
            ),
        onDone: () {
          _markOnBoardingComplete(); // 온보딩 완료 처리
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Register()),
          );
        },
        next: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
        dotsDecorator: DotsDecorator(
            color: Colors.grey,
            size: const Size(10, 10),
            activeSize: const Size(20, 10),
            activeColor: Colors.black,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
        //freeze: true,
      ),
    );
  }
}
