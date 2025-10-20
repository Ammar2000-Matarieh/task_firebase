import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_firebase/controllers/auth_controller.dart';
import 'package:task_firebase/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final fullNameController = TextEditingController();
  final locationController = TextEditingController();
  final ageController = TextEditingController();
  final registerKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Screen",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: registerKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Account",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),

              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email does not empty please fill field ";
                  } else if (value.length < 4) {
                    return "Email does not less than 4 char please fill field ";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(CupertinoIcons.mail),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password does not empty please fill field ";
                  } else if (value.length < 8) {
                    return "Password does not less than 8 char please fill field ";
                  }
                  return null;
                },
                controller: passController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(CupertinoIcons.lock),
                  suffixIcon: Icon(CupertinoIcons.eye),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "FullName does not empty please fill field ";
                  } else if (value.length < 10) {
                    return "FullName does not less than 10 char please fill field ";
                  }
                  return null;
                },
                controller: fullNameController,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(CupertinoIcons.person),
                  // suffixIcon: Icon(CupertinoIcons.eye),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Location does not empty please fill field ";
                  } else if (value.length < 4) {
                    return "Location does not less than 4 char please fill field ";
                  }
                  return null;
                },
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(CupertinoIcons.location),
                  // suffixIcon: Icon(CupertinoIcons.eye),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Age does not empty please fill field ";
                  } else if (value.length < 2) {
                    return "Age does not less than 2 char please fill field ";
                  }
                  return null;
                },
                controller: ageController,
                decoration: InputDecoration(
                  hintText: "Age",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // prefixIcon: Icon(CupertinoIcons.),
                  // suffixIcon: Icon(CupertinoIcons.eye),
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (registerKey.currentState!.validate()) {
                          // call function :
                          AuthController.createAccount(
                            email: emailController.text.trim(),
                            password: passController.text.trim(),
                            fullName: fullNameController.text.trim(),
                            location: locationController.text.trim(),
                            age: ageController.text.trim(),
                            // emailController.text.trim(),
                            // passController.text.trim(),
                          );

                          emailController.clear();
                          passController.clear();
                          fullNameController.clear();
                          locationController.clear();
                          ageController.clear();
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have an account ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text("Login"),
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
