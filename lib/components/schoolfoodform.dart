import 'package:flutter/material.dart';

class FoodForm extends StatelessWidget {
  final String date, rice1, rice2, rice3, rice4, rice5, rice6, rice7;

  const FoodForm({
    super.key,
    required this.date,
    required this.rice1,
    required this.rice2,
    required this.rice3,
    required this.rice4,
    required this.rice5,
    required this.rice6,
    required this.rice7,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 180,
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              date,
              style: TextStyle(fontFamily: 'BMHANNA', fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rice1,
                  style: TextStyle(
                      fontFamily: 'BMHANNA',
                      fontSize: 15,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(rice2,
                  style: TextStyle(
                      fontFamily: 'BMHANNA',
                      fontSize: 15,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(rice3,
                  style: TextStyle(
                      fontFamily: 'BMHANNA',
                      fontSize: 15,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(rice4,
                  style: TextStyle(
                      fontFamily: 'BMHANNA',
                      fontSize: 15,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(rice5,
                  style: TextStyle(
                      fontFamily: 'BMHANNA',
                      fontSize: 15,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(rice6,
                  style: TextStyle(
                      fontFamily: 'BMHANNA',
                      fontSize: 15,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(rice7,
                  style: TextStyle(
                      fontFamily: 'BMHANNA',
                      fontSize: 15,
                      color: Colors.black54),
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1.0),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1.0)
          ]),
    );
  }
}
