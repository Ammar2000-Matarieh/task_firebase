import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_firebase/screens/adv_list.dart';
import 'package:task_firebase/screens/categories_list_screen.dart';
import 'package:task_firebase/screens/login_screen.dart';
import 'package:task_firebase/screens/user_list_screen.dart';
// import 'package:task_firebase/services/notifications_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UsersListScreen()),
                ),
                child: const Text(
                  "List Users",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdvListScreen()),
                ),
                child: const Text(
                  "List Advertisements",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoryListScreen()),
                ),
                child: const Text(
                  "List Categories",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // Notifications :
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                onPressed: () async {
                  // LocalNotifyService.displayTest(1, "hi", "hello", "ammar");
                  try {
                    // String? token = await FirebaseMessaging.instance.getToken();

                    // print(token);

                    // FirebaseMessaging.onBackgroundMessage();

                    await FirebaseMessaging.instance.subscribeToTopic("users");
                    log('✅ Subscribed to topic: users');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم تفعيل الإشعارات بنجاح')),
                    );
                  } catch (e) {
                    log('❌ Error subscribing to topic: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('حدث خطأ في تفعيل الإشعارات')),
                    );
                  }
                },
                // onPressed: () {
                //   // call notifications :
                //   // FirebaseMessaging.instance.subscribeToTopic("users");

                //   // FirebaseMessaging.onMessageOpenedApp.listen((message) {
                //   //   print(message.notification!.body);
                //   //   print(message.notification!.title);
                //   // });

                // },
                child: const Text(
                  "Push Notifications ",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
