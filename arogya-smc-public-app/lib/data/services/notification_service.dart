import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {
  /// Call this method after the user successfully logs in
  static Future<void> registerFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('fcm_token');
    if (token == null) return;

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/notifications/register'),
        headers: {
          'Content-Type': 'application/json',
          // Include auth cookie here - the http client will include them automatically
          // if you use the same client configuring cookies.
        },
        body: jsonEncode({'fcmToken': token, 'platform': 'android'}),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('FCM token successfully registered to backend');
      } else {
        debugPrint('Failed to register FCM token. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error registering FCM token: $e');
    }
  }
}
