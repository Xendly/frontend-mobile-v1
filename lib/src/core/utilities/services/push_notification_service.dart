import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xendly_mobile/src/core/utilities/services/notification_service.dart';

class PushNotificationService {
  static String? token;

  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = await _fcm.getToken();
    await prefs.setString("fcm_token", token!);
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    await Firebase.initializeApp();

    if (notification != null && android != null) {
      NotificationService.showNotificationWithoutSound(
        notification.hashCode,
        notification.title!,
        notification.body!,
        Colors.black,
      );
    }
  }

  static Future<void> initialize() async {
    token = await _fcm.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        NotificationService.showNotificationWithoutSound(
          notification.hashCode,
          notification.title!,
          notification.body!,
          Colors.black,
        );
      }
      print("notification msg - $notification");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        NotificationService.showNotificationWithoutSound(
          notification.hashCode,
          notification.title!,
          notification.body!,
          Colors.black,
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: false,
    );

    getToken();
  }
}
