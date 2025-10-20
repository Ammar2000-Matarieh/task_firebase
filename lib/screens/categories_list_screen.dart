import 'package:flutter/material.dart';
import 'package:task_firebase/controllers/categories_controller.dart';
import 'package:task_firebase/screens/add_edit_cat.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late Future<List<Map<String, dynamic>>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    _categoriesFuture = CategoriesController.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: FutureBuilder(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories yet.'));
          }

          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var cat = categories[index];
              return ListTile(
                title: Text(cat['name'] ?? ''),
                subtitle:
                    cat['image_url'] != null && cat['image_url'].isNotEmpty
                    ? Image.network(cat['image_url'], width: 100, height: 70)
                    : const SizedBox(),
                // subtitle: Image.network(
                //   cat['image_url'] ?? '',
                //   width: 100,
                //   height: 70,
                // ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryAddEditScreen(
                          categoryId: cat['id'],
                          currentName: cat['name'],
                          imageName: cat['image_url'],
                        ),
                      ),
                    );
                    setState(_loadCategories);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.green,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CategoryAddEditScreen()),
          );
          setState(_loadCategories);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
