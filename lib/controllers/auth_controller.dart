import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_firebase/models/users_info_model.dart';

class AuthController {
  // create account :

  // Create Account :
  static Future<void> createAccount({
    required String email,
    required String password,
    required String fullName,
    required String location,
    required String age,
  }) async {
    try {
      // 1️⃣ إنشاء المستخدم في Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user?.uid;

      // 2️⃣ حفظ بياناته في Firestore
      if (uid != null) {
        Map<String, dynamic> userData = {
          'uid': uid,
          'email': email,
          'fullName': fullName,
          'location': location,
          'age': age,
          'createdAt': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(userData);

        // 3️⃣ تحويل البيانات إلى model (بعد التخزين)
        UsersInfoModel usersInfoModel = UsersInfoModel.fromJson(userData);

        print("✅ User created and saved to Firestore");
        print("👤 Full Name: ${usersInfoModel.fullName}");
      }
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuth Error: ${e.message}");
    } catch (e) {
      print("❌ Unknown Error: $e");
    }
  }

  // Login :
  static Future<void> loginAccount(String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      print("✅ Logged in: ${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      print("❌ Login Error: ${e.message}");
    }
  }

  // check login :
  Future<User?> checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("✅ User still logged in: ${user.email}");
    } else {
      print("⚠️ No user logged in");
    }
    return user;
  }
}
