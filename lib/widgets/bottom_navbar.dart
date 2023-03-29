import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:snappio_frontend/screens/chat_section.dart';
import 'package:snappio_frontend/screens/posts_feed.dart';
import 'package:snappio_frontend/screens/profile_section.dart';
import 'package:snappio_frontend/screens/upload_section.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = '/navbar';
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static final PageController _controller = PageController();

  void itemPressed(int index) {
    setState(() {_selectedIndex = index;});
    _controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {_selectedIndex = value;});
        },
        children: const [
          ChatSection(),
          PostsFeed(),
          UploadSection(),
          ProfileSection(),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        snakeShape: SnakeShape.circle,
        backgroundColor: Colors.transparent,
        snakeViewColor: Theme.of(context).cardColor,
        selectedItemColor: Theme.of(context).splashColor,
        unselectedItemColor: Theme.of(context).primaryColor,
        // showSelectedLabels: true,
        elevation: 15,
        currentIndex: _selectedIndex,
        onTap: itemPressed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.chatbubble_ellipses_outline),
            activeIcon: Icon(Ionicons.chatbubble_ellipses),
            label: 'chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.heart_circle_outline),
            activeIcon: Icon(Ionicons.heart),
            label: 'posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.add_circle_outline),
            activeIcon: Icon(Ionicons.add_circle),
            label: 'upload',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Ionicons.search_circle_outline),
          //   activeIcon: Icon(Ionicons.search),
          //   label: 'search',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_circle_outline),
            activeIcon: Icon(Ionicons.person),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
