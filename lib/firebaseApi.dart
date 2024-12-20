// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseAPI {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  final _androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  );

  Future<void> initNotifications() async {
    await Firebase.initializeApp();
    await firebaseMessaging.requestPermission();

    final fcmToken = await firebaseMessaging.getToken();
    print("Token: $fcmToken");
    await GetStorage().write('fcmtoken', fcmToken);

    await initLocalNotification();
    await initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    if (message.notification != null) {
      localNotifications.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker',
            styleInformation: BigTextStyleInformation(
                message.notification!.body!,
                htmlFormatBigText: true,
                contentTitle: null),
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }

  Future<void> initLocalNotification() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: iOS);

    await localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (response) {
      if (response.payload != null) {
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        handleMessage(message);
      }
    });

    if (Platform.isAndroid) {
      final androidPlatform =
          localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlatform != null) {
        await androidPlatform.createNotificationChannel(_androidChannel);
      }
    } else if (Platform.isIOS) {
      final iOSPlatform =
          localNotifications.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (iOSPlatform != null) {
        await iOSPlatform.requestPermissions(
            alert: true, badge: true, sound: true);
      }
    }
  }

  Future<void> initPushNotifications() async {
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((message) {
      print("message$message");
      if (message.notification != null) {
        localNotifications.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_launcher',
              importance: Importance.high,
              priority: Priority.high,
              ticker: 'ticker',
              styleInformation: BigTextStyleInformation(
                  message.notification!.body!,
                  htmlFormatBigText: true,
                  contentTitle: null),
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }
}
