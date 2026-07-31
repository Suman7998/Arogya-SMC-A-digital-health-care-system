// lib/main.dart
//
// Arogya SMC Citizen App
// Solapur Municipal Corporation – Digital Health Platform
//
// Entry point: ProviderScope + Hive init + GoRouter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Background message: ${message.messageId}");
}

Future<void> _requestPermissions() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> _storeToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('fcm_token', token);
}

void _showNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'health_alerts_channel',
          'Health Alerts',
          channelDescription: 'Notifications for health alerts',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('FirebaseInitError: $e');
  }

  // Lock orientation to portrait
  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } catch (e) {}

  // Configure status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize Hive
  try {
    await Hive.initFlutter();
    await Hive.openBox(AppConstants.hospitalsBox);
    await Hive.openBox(AppConstants.settingsBox);
    await Hive.openBox(AppConstants.alertsBox);
    await Hive.openBox(AppConstants.advisoriesBox);
  } catch (e) {
    debugPrint('HiveInitError: $e');
  }

  // Setup local notifications
  try {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  } catch (e) {
    debugPrint('LocalNotificationsInitError: $e');
  }

  // Start app immediately after essential local config is ready
  runApp(
    const ProviderScope(
      child: ArogyaSMCApp(),
    ),
  );

  // Fetch tokens and request permissions asynchronously in the background
  // to avoid hanging on the splash screen due to network or OS dialog delays.
  _requestPermissions().then((_) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _storeToken(token);
    }
  }).catchError((e) {
    debugPrint('Error fetching FCM token: $e');
  });

  // Listen to token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    await _storeToken(newToken);
  });

  // Listen to foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showNotification(message);
  });

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

class ArogyaSMCApp extends StatelessWidget {
  const ArogyaSMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: goRouter,
    );
  }
}