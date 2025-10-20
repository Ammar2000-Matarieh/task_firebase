import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesController {
  // add :
  static Future<void> addCategory(String name, String image) async {
    try {
      await FirebaseFirestore.instance.collection('categories').add({
        'name': name,
        'image_url': image,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("✅ Category added");
    } catch (e) {
      print("❌ Error adding category: $e");
    }
  }

  // edit :
  static Future<void> editCategoryName(
    String docId,
    String newName,
    String newImage,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(docId)
          .update({'name': newName, 'image_url': newImage});
      print("✅ Category name updated");
    } catch (e) {
      print("❌ Error updating category name: $e");
    }
  }

  // all :
  static Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .get();

      List<Map<String, dynamic>> categories = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();

      print("🏷️ Categories count: ${categories.length}");
      return categories;
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }
}
