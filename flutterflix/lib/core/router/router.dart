import 'package:flutterflix/core/router/router_constants.dart';
import 'package:flutterflix/core/router/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

GoRouter? _previousRouter;
final GlobalKey<NavigatorState> navKey = rootNavigatorKey;

final routerProvider = Provider<GoRouter>((ref) {
  // final authController = ref.watch(authControllerProvider);

  _previousRouter = GoRouter(
    navigatorKey: navKey,
    debugLogDiagnostics: kReleaseMode ? false : true,
    observers: [],
    initialLocation: _previousRouter?.routeInformationProvider.value.uri.path,
    redirect: (context, state) {
      final path = state.uri.path;
      if (path == '/' || path.contains(RouterConstants.homeRoute.name!)) {
        return RouterConstants.landingPageRoute.path;
      } else {
        if (RouterConstants.unAuthenticatedRoutePaths.contains(path)) {
          return RouterConstants.homeRoute.path;
        }
        return null;
      }
    },
    routes: $appRoutes,
  );

  return _previousRouter!;
});
