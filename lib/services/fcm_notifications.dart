import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:task_firebase/services/notifications_app.dart';

class FMServices {
  static Future<void> initialize() async {
    try {
      // طلب الأذونات
      NotificationSettings settings = await FirebaseMessaging.instance
          .requestPermission(
            alert: true,
            badge: true,
            sound: true,
            criticalAlert: false,
            provisional: false,
          );

      log('📱 Notification permission status: ${settings.authorizationStatus}');

      // إعدادات الإشعارات في الواجهة
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      // الحصول على التوكن
      String? token = await FirebaseMessaging.instance.getToken();
      log('🔥 FCM Token: $token');

      // تحديث التوكن
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        log('🔄 FCM Token refreshed: $newToken');
        // هنا يمكنك إرسال التوكن الجديد لسيرفرك
      });

      // معالجة الإشعارات في مختلف الحالات
      _setupMessageHandlers();
    } catch (e) {
      log('❌ Error initializing FCM: $e');
    }
  }

  static void _setupMessageHandlers() {
    // عندما يكون التطبيق مفتوح (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('🎯 Foreground message received');
      log('📦 Message data: ${message.data}');

      // عرض إشعار محلي
      if (message.notification != null) {
        LocalNotifyService.displayTest(
          message.data['id'] != null
              ? int.parse(message.data['id'])
              : DateTime.now().millisecondsSinceEpoch.remainder(100000),
          message.notification?.title,
          message.notification?.body,
          message.data.toString(),
        );
      }
    });

    // عندما يكون التطبيق في الخلفية (background) ويتم النقر على الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('📱 App opened from background/terminated');
      log('📦 Message data: ${message.data}');

      // معالجة التنقل هنا
      _handleMessageNavigation(message);
    });

    // عندما يكون التطبيق مغلقاً تماماً (terminated) ويتم فتحه عبر الإشعار
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        log('🚀 App opened from terminated state');
        log('📦 Message data: ${message.data}');

        // تأخير معالجة التنقل لضمان تحميل التطبيق بالكامل
        Future.delayed(const Duration(seconds: 2), () {
          _handleMessageNavigation(message);
        });
      }
    });
  }

  static void _handleMessageNavigation(RemoteMessage message) {
    // هنا يمكنك معالجة التنقل بناءً على محتوى الرسالة
    final data = message.data;

    if (data['type'] == 'order') {
      // انتقل لصفحة الطلبات
      // Navigator.push(context, MaterialPageRoute(builder: (_) => OrdersPage()));
    } else if (data['type'] == 'promotion') {
      // انتقل لصفحة العروض
      // Navigator.push(context, MaterialPageRoute(builder: (_) => PromotionsPage()));
    }
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      log('✅ Subscribed to topic: $topic');
    } catch (e) {
      log('❌ Error subscribing to topic $topic: $e');
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      log('✅ Unsubscribed from topic: $topic');
    } catch (e) {
      log('❌ Error unsubscribing from topic $topic: $e');
    }
  }

  static Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      log('✅ FCM token deleted');
    } catch (e) {
      log('❌ Error deleting FCM token: $e');
    }
  }
}
