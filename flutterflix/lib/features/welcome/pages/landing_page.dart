import 'package:flutter/material.dart';
import 'package:flutterflix/core/theme/app_dimensions.dart';
import 'package:flutterflix/widgets/appbar/appbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/landing-background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.colorBurn),
          ),
        ),
        child: Center(child: Text('Welcome to Flutterflix', style: TextStyle(color: Colors.white, fontSize: 32))),
      ),
    );
  }
}
