import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/pages/create_post/create_post.dart';
import 'package:schoolapp/services/auth/auth_service.dart';
import 'package:schoolapp/utility/utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //sign out
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut(context);
  }

  final TextEditingController _searchController = TextEditingController();
  bool leftclick = true;
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  onCraetePost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePost()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: '검색 ...', prefixIcon: Icon(Icons.search)),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.red),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.supervised_user_circle,
                  size: 30,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        leftclick = true;
                      });
                    },
                    child: Text(
                      '전국 고등학생 (익명)',
                      style: SafeGoogleFont(
                        'Noto Sans KR',
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color:
                            leftclick ? Color(0xff000000) : Color(0xffaeaeae),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero)))
                        .copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                  ),
                )),
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        leftclick = false;
                      });
                    },
                    child: Text(
                      '내 고등학교',
                      style: SafeGoogleFont(
                        'Noto Sans KR',
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color:
                            !leftclick ? Color(0xff000000) : Color(0xffaeaeae),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero)))
                        .copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _page,
          children: [],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onCraetePost,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _page == 0 ? Icons.home_filled : Icons.home_outlined,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 2
                    ? Icons.notification_add_outlined
                    : Icons.notification_important_outlined,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
