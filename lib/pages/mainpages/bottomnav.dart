import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:schoolapp/pages/mainpages/account.dart';
import 'package:schoolapp/pages/mainpages/community.dart';
import 'package:schoolapp/pages/mainpages/notification.dart';
import 'package:schoolapp/pages/mainpages/school_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int _selectedIndex = 0;

  final screens = [
    MainPage(),
    SchoolPage(),
    NotificationPage(),
    Account()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
        bottomNavigationBar: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.chat_outlined,
              text: '커뮤니티',
            ),
            GButton(
              icon: Icons.school_outlined,
              text: '내 학교',
            ),
            GButton(
              icon: Icons.notifications_outlined,
              text: '알림',
            ),
            GButton(
              icon: Icons.account_box_outlined,
              text: '내 계정',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        )
    );
  }
}
