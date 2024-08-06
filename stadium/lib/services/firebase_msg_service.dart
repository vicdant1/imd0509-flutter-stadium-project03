import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    await setupLocalNotifications();
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Permission: ${notificationSettings.authorizationStatus}');

    String? token = await firebaseMessaging.getToken();
    print('Token: $token');

    firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(message.notification?.title ?? '',
            message.notification!.body ?? '');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showLocalNotification(
          message.notification?.title ?? '', message.notification?.body ?? '');
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      showLocalNotification(
          message.notification?.title ?? '', message.notification?.body ?? '');
    });
  }

  void showLocalNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'payload',
    );
  }

  Future<void> setupLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: IOSInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
