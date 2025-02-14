import 'dart:developer';

import 'package:curso_de_verano/core/routes/routes.dart';
import 'package:curso_de_verano/core/themes/app_theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final fcmToken = await FirebaseMessaging.instance.getToken();

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  if (fcmToken!= null) {
    log('FCM Token: $fcmToken');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {

    

    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
