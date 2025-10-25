import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:task_firebase/firebase_options.dart';
import 'package:task_firebase/run_app.dart';
import 'package:task_firebase/services/background_message.dart';
import 'package:task_firebase/services/fcm_notifications.dart';
import 'package:task_firebase/services/notifications_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // تسجيل background handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await LocalNotifyService.initialize();
  await FMServices.initialize();
  // 🔸 check user :
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(isLoggedIn: user != null));
}
