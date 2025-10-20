import 'package:cloud_firestore/cloud_firestore.dart';

class UsersController {
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      List<Map<String, dynamic>> users = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("👥 Users count: ${users.length}");
      return users;
    } catch (e) {
      print("❌ Error fetching users: $e");
      return [];
    }
  }

  // add adv :
  static Future<void> addAdv(String name, String image) async {
    try {
      await FirebaseFirestore.instance.collection('advs').add({
        'name': name,
        'image': image,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("✅ Advertisement added");
    } catch (e) {
      print("❌ Error adding adv: $e");
    }
  }

  // edit :
  static Future<void> editAdvName(
    String docId,
    String newName,
    String imageNew,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('advs').doc(docId).update({
        'name': newName,
        'image': imageNew,
      });
      print("✅ Adv name updated");
    } catch (e) {
      print("❌ Error updating adv name: $e");
    }
  }

  // all adv :
  static Future<List<Map<String, dynamic>>> getAllAdvs() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('advs')
          .get();

      List<Map<String, dynamic>> advs = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();

      print("📢 Advs count: ${advs.length}");
      return advs;
    } catch (e) {
      print("❌ Error fetching advs: $e");
      return [];
    }
  }
}
