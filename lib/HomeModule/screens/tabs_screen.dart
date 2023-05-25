import 'package:flutter/material.dart';

import 'package:tusharghone/HomeModule/screens/communityScreen.dart';
import 'package:tusharghone/HomeModule/screens/homeScreen.dart';
import 'package:tusharghone/HomeModule/screens/profile.dart';
import 'package:tusharghone/HomeModule/screens/topTabScreen.dart';
import 'package:tusharghone/HomeModule/screens/wishListScreen.dart';
import 'package:tusharghone/hexColor.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabsScreen';
  int index;
  TabsScreen({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomeScreen(),
    TopTabScreen(),
    MyCommunityScreen(),
    WishlistScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(buttoncolor),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_sharp),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'WishList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
