import 'package:flutter/material.dart';
import 'package:task_firebase/controllers/users_controller.dart';

class AdvAddEditScreen extends StatefulWidget {
  final String? advId;
  final String? currentName;
  final String? currentImage;
  const AdvAddEditScreen({
    super.key,
    this.advId,
    this.currentName,
    this.currentImage,
  });

  @override
  State<AdvAddEditScreen> createState() => _AdvAddEditScreenState();
}

class _AdvAddEditScreenState extends State<AdvAddEditScreen> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final keyAdv = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.currentName != null) {
      nameController.text = widget.currentName!;
    }
    if (widget.currentImage != null) {
      // ✅ تعيين رابط الصورة
      imageController.text = widget.currentImage!;
    }
  }
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.currentName != null) {
  //     nameController.text = widget.currentName!;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.advId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Adv' : 'Add Adv')),
      body: Form(
        key: keyAdv,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  labelText: 'Adv Name',
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

                  labelText: 'Adv Image URl',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (keyAdv.currentState!.validate()) {
                          if (isEdit) {
                            await UsersController.editAdvName(
                              widget.advId!,
                              nameController.text,
                              imageController.text,
                            );
                          } else {
                            await UsersController.addAdv(
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
                        isEdit ? 'Save Changes' : 'Add Adv',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
