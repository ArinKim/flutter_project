// lib/routes.dart
import 'package:flutterflix/features/splash/pages/splash_screen.dart';
import 'package:flutterflix/features/welcome/pages/landing_page.dart';
import 'package:flutterflix/features/welcome/pages/welcome_page.dart';
import 'package:flutterflix/features/home/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'router_constants.dart';

part 'routes.g.dart'; // This file will be generated

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@RouterConstants.welcomePageRoute
class WelcomeRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => customPageBuilder(const WelcomePage());
}

@RouterConstants.landingPageRoute
class LandingRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => customPageBuilder(const LandingPage());
}

@RouterConstants.splashPageRoute
class SplashRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => customPageBuilder(const SplashPage());
}

@RouterConstants.homeRoute
class HomeRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => customPageBuilder(const HomePage());
}

// Utility function to apply fade transition only on web
Page<void> customPageBuilder(Widget child) {
  if (kIsWeb) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  } else {
    return MaterialPage(child: child); // Default transition on mobile
  }
}
