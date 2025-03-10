import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/pages/home_page.dart';
import 'package:fluttergram/pages/post_page.dart';
import 'package:fluttergram/pages/profile_page.dart';
import 'package:fluttergram/pages/upload_post_landing_page.dart';
import 'package:fluttergram/pages/upload_post_page.dart';
import 'package:fluttergram/utils/colours.dart';

const webScreenSize = 600;

List<Widget> homeScreenBottomMenus = [
  const HomePage(),
  const Text(
    "Search",
    style: TextStyle(color: blackColour),
  ),
  const UploadPostLandingPage(),
  const Text(
    "Video",
    style: TextStyle(color: blackColour),
  ),
  ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid),
];
