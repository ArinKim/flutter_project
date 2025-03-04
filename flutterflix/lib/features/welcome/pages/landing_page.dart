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
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('/assets/images/landing-background.png'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('Welcome to Flutterflix'), SizedBox(height: 20), Text('Your one-stop shop for all things Flutter')],
        ),
      ),
    );
  }
}
