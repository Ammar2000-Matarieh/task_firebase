import 'package:flutter/material.dart';
import 'package:task_firebase/controllers/categories_controller.dart';

class CategoryAddEditScreen extends StatefulWidget {
  final String? categoryId;
  final String? currentName;
  final String? imageName;

  const CategoryAddEditScreen({
    super.key,
    this.categoryId,
    this.currentName,
    this.imageName,
  });

  @override
  State<CategoryAddEditScreen> createState() => _CategoryAddEditScreenState();
}

class _CategoryAddEditScreenState extends State<CategoryAddEditScreen> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final keyCat = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.currentName != null) {
      nameController.text = widget.currentName!;
    }
    if (widget.imageName != null) {
      imageController.text = widget.imageName!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.categoryId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Category' : 'Add Category')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: keyCat,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    return "Please Error value Field ";
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.),
                  labelText: 'Category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return "Please Error value Field ";
                  }
                  return null;
                },
                controller: imageController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.image),

                  labelText: 'Category Image URl',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                scrollPhysics: AlwaysScrollableScrollPhysics(),
              ),
              // TextField(
              //   controller: nameController,
              //   decoration: const InputDecoration(labelText: 'Category Name'),
              // ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (keyCat.currentState!.validate()) {
                          if (isEdit) {
                            await CategoriesController.editCategoryName(
                              widget.categoryId!,
                              nameController.text,
                              imageController.text,
                            );
                          } else {
                            await CategoriesController.addCategory(
                              nameController.text,
                              imageController.text,
                            );
                          }
                          Navigator.pop(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Error Please Fill Input name"),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                    10,
                                                  ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                    10,
                                                  ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        isEdit ? 'Save Changes' : 'Add Category',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
