import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/pages/home_page.dart';
import 'package:fluttergram/pages/profile_page.dart';
import 'package:fluttergram/pages/upload_post_page.dart';
import 'package:fluttergram/utils/global.dart';

class PageProvider extends ChangeNotifier {
  late Widget _currentScreen = const HomePage();
  Widget get currentScreen => _currentScreen;
  set currentScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }

  void changeCurrentScreen(int index) {
    _currentScreen = homeScreenBottomMenus.elementAt(index);
    notifyListeners();
  }
}

enum CustomScreensEnum { homeScreen, uploadPostScreen, profileScreen }
