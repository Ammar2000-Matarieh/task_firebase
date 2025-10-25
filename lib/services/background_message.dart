import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:task_firebase/services/notifications_app.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('🌙 Background message received: ${message.messageId}');
  log('📦 Data: ${message.data}');

  if (message.notification != null) {
    await LocalNotifyService.displayTest(
      message.data['id'] ?? DateTime.now().millisecondsSinceEpoch,
      message.notification?.title,
      message.notification?.body,
      message.data.toString(),
    );
  }
}
