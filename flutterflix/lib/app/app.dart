import 'package:flutterflix/core/router/router.dart';
// import 'package:beacon/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Flutterflix',
      // theme: AppTheme.createTheme(brightness: Brightness.light),
      // darkTheme: AppTheme.createTheme(brightness: Brightness.dark),
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
