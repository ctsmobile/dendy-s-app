// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseAPI {
  final firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.defaultImportance);
  final localNotifications = FlutterLocalNotificationsPlugin();
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print("12token$fcmToken");
    await GetStorage().write('fcmtoken', fcmToken);
    initPushNotifications();
    initLocalNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    } else {}
  }

  Future initLocalNotification() async {
    const DarwinInitializationSettings iOS = DarwinInitializationSettings();
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@drawable/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      // final message=RemoteMessage.fromMap(jsonDecode(payload))
      // handleMessage(message);
    });

    // final platform=localNotifications.resolvePlatformSpecificImplementation();

    // await platform?.
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification == null) {
        return;
      } else {
        localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    _androidChannel.id, _androidChannel.name,
                    channelDescription: _androidChannel.description,
                    icon: '@drawable/ic_launcher')),
            payload: jsonEncode(message.toMap()));
      }
    });
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }
}
