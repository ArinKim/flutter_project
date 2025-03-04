import 'package:flutterflix/core/router/routes.dart';
import 'package:go_router/go_router.dart';

class RouterConstants {
  // Top level Routes.

  static const homeRoute = TypedGoRoute<HomeRoute>(
    path: '/home', // Use constant for the home path
    name: 'home',
    // routes: [chatPageRoute, preferencesPageRoute],
  );

  // Individual ROutes

  // static const loginPageRoute = TypedGoRoute<LoginPageRoute>(
  //   path: '/login', // Use constant for the home path
  // );

  // static const verifyEmailPageRoute = TypedGoRoute<VerifyEmailPageRoute>(
  //   path: '/verify-email/:email', // Use constant for the home path
  // );

  // static const signupPageRoute = TypedGoRoute<SignupPageRoute>(
  //   path: '/signup', // Use constant for the home path
  // );

  static const welcomePageRoute = TypedGoRoute<WelcomeRoute>(
    path: '/welcome', // Use constant for the home path
  );
  static const landingPageRoute = TypedGoRoute<LandingRoute>(
    path: '/landing', // Use constant for the home path
  );
  static const splashPageRoute = TypedGoRoute<SplashRoute>(
    path: '/', // Use constant for the home path
  );

  // Authenticated Routes
  // These routes are nested under the home route so all routes must not being with a /(slash)
  // These routes must not be annotated with @RouterConstants since they are nested under
  // the home route only home route is annotated with @RouterConstants
  // static const chatPageRoute = TypedGoRoute<ChatPageRoute>(
  //   path: 'chat_page', // Use constant for the home path
  // );

  // static const preferencesPageRoute = TypedGoRoute<PreferencesPageRoute>(
  //   path: 'preferences', // Use constant for the home path
  // );

  static final unAuthenticatedRoutePaths = [splashPageRoute.path, welcomePageRoute.path, homeRoute.path];
  // static final authenticatedRoutePaths = [homeRoute.path];
}
