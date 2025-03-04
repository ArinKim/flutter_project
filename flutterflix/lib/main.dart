import 'package:flutterflix/app/app.dart';
// import 'package:flutterflix/core/services/remote_config/remote_config_service.dart';
// import 'package:flutterflix/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await RemoteConfigService.initialize();

  runApp(const ProviderScope(child: MyApp()));
}
