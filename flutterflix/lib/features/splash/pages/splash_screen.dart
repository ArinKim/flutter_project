import 'package:flutterflix/core/router/routes.dart';
import 'package:flutterflix/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 300), () {
      LandingRoute().go(context); // Navigate to the landing page
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [colors.primary, colors.secondary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
      ),
    );
  }
}
