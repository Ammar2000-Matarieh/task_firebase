import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

class LocalNotifyService {
  static final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const String icon = '@mipmap/ic_launcher';

    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: const AndroidInitializationSettings(icon),
          iOS: DarwinInitializationSettings(
            requestSoundPermission: true,
            requestAlertPermission: true,
            requestBadgePermission: true,
            notificationCategories: [
              DarwinNotificationCategory(
                'demo Category',
                actions: <DarwinNotificationAction>[
                  DarwinNotificationAction.plain('id_1', 'Action 1'),
                  DarwinNotificationAction.plain(
                    'id_2',
                    'Action 2',
                    options: <DarwinNotificationActionOption>{
                      DarwinNotificationActionOption.destructive,
                    },
                  ),
                  DarwinNotificationAction.plain(
                    'id_3',
                    'Action 3',
                    options: <DarwinNotificationActionOption>{
                      DarwinNotificationActionOption.foreground,
                    },
                  ),
                ],
                options: <DarwinNotificationCategoryOption>{
                  DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
                },
              ),
            ],
          ),
        );

    if (Platform.isAndroid) {
      await localNotification
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestNotificationsPermission();
    }

    if (Platform.isIOS) {
      await localNotification
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()!
          .requestPermissions(alert: true, badge: true, sound: true);
    }

    await localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
    );
  }

  static Future<void> _createNotificationChannel() async {
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      'custom_sound_channel', // id
      'Custom Sound Notifications', // name
      description: 'Notifications with custom sound',
      importance: Importance.max,
      // priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 500, 1000, 500]),
    );

    await localNotification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()!
        .createNotificationChannel(channel);
  }

  static Future<void> displayTest(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    try {
      const DarwinNotificationDetails iOS = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'notification_sound.mp3',
        categoryIdentifier: 'demo Category',
      );

      final AndroidNotificationDetails android = AndroidNotificationDetails(
        'custom_sound_channel', // نفس الـ channel id
        'Custom Sound Notifications',
        channelDescription: 'Notifications with custom sound',
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 500, 1000, 500]),
        channelShowBadge: true,
        priority: Priority.high,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification_sound'),
        actions: [
          AndroidNotificationAction('mute', 'MUTE'),
          AndroidNotificationAction('Mark as read', 'MARK AS READ'),
        ],
      );

      final NotificationDetails notifyDetails = NotificationDetails(
        iOS: iOS,
        android: android,
      );

      await localNotification.show(
        id,
        title ?? '',
        body ?? '',
        notifyDetails,
        payload: payload,
      );
    } on Exception catch (e) {
      debugPrint('Local notification error: $e');
    }
  }

  static Future<void> displaySimpleNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const DarwinNotificationDetails iOS = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const AndroidNotificationDetails android = AndroidNotificationDetails(
        'custom_sound_channel',
        'Custom Sound Notifications',
        channelDescription: 'Notifications with custom sound',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        playSound: true,
        enableVibration: true,
      );

      const NotificationDetails notifyDetails = NotificationDetails(
        iOS: iOS,
        android: android,
      );

      await localNotification.show(
        id,
        title,
        body,
        notifyDetails,
        payload: payload,
      );
    } on Exception catch (e) {
      debugPrint('Simple notification error: $e');
    }
  }

  static void onDidReceiveNotification(NotificationResponse details) {
    log('Notification received: ${details.payload}');

    if (details.payload == 'New Order') {
      log('New Order notification tapped');
      // goTo(RoutesNames.orders);
    }
  }
}
