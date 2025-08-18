import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shop/future/shop/page/favorit/favorit.dart';
import 'package:shop/future/shop/page/home/home.dart';
import 'package:shop/future/shop/page/profile/profile.dart';
import 'package:shop/future/shop/page/search/search.dart';

class BottonPage extends StatefulWidget {
  const BottonPage({super.key});

  @override
  State<BottonPage> createState() => _BottonPageState();
}

class _BottonPageState extends State<BottonPage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    Home(),
    Search(),
    Favorit(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.perm_identity, size: 30, color: Colors.white),
        ],
        color: Colors.grey.shade900,
        buttonBackgroundColor: Colors.grey.shade900,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
