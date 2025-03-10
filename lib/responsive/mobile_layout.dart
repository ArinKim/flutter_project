import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttergram/providers/page_provider.dart';
import 'package:fluttergram/utils/colours.dart';
import 'package:fluttergram/utils/global.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Provider.of<PageProvider>(context, listen: false).changeCurrentScreen(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body
      body: Center(child: Consumer<PageProvider>(builder: (context, page, child) {
        return page.currentScreen;
      })),
      // Bottom bar
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        selectedIconTheme: const IconThemeData(color: selectedButtonColour),
        unselectedIconTheme: const IconThemeData(color: unselectedButtonColour),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ' ', // Must be none-null label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ' ', // Must be none-null label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined),
            label: ' ', // Must be none-null label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.slow_motion_video_rounded),
            label: ' ', // Must be none-null label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: ' ', // Must be none-null label
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
