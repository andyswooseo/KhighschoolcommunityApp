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
  @override
  Widget build(BuildContext context) {
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
        onDone: () {},
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
