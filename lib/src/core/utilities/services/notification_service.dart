import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:xendly_mobile/src/config/routes.dart';

class NotificationService {
  // define the variable for the notification
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // codebase for handling the local_notifications plugin
    var androidInitSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitSettings = const IOSInitializationSettings();
    var initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    // onSelectNotification method
    Future onSelectNotification(String? payload) async {
      print("response from payload -$payload");
      // showDialog(
      //   // context: context,
      //   builder: (_) => AlertDialog(
      //     title: const Text("Here is the payload"),
      //     content: Text("Payload: $payload"),
      //   ),
      // );
    }

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: onSelectNotification,
    );

    // create the channel and notification plugin
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    // resolve platform specific implementation
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // method to show notification without sound
  static Future showNotificationWithoutSound(
      int notificationId,
      String notificationTitle,
      String notificationDescription,
      Color? color) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      color: color,
      icon: "@mipmap/ic_launcher",
      playSound: false,
      importance: Importance.max,
      priority: Priority.max,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      presentSound: false,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationDescription,
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }
}
