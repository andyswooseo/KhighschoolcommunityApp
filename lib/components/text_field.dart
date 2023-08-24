import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width - 50,
        height: 55,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffaeaeae)),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffaeaeae))
            ),
            fillColor: const Color(0xffffffff),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Noto Sans KR',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.0,
              color: Color(0xffbdbdbd)
            ),
          ),
        ),
      ),
    );
  }
}
