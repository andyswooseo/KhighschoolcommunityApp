import 'package:flutter/material.dart';
import 'package:schoolapp/utility/utils.dart';

class SelectGroup extends StatelessWidget {

  final String text;
  const SelectGroup({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        '전국 고등학생 (익명)',
        style: SafeGoogleFont(
          'Noto Sans KR',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: const Color(0xff000000),
        ),
      ),
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero)
          )
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
    );
  }
}
