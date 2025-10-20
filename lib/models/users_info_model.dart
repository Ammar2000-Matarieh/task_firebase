import 'package:cloud_firestore/cloud_firestore.dart';

class UsersInfoModel {
  final String uid;
  final String email;
  final String fullName;
  final String location;
  final String age;
  final DateTime? createdAt;

  UsersInfoModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.location,
    required this.age,
    this.createdAt,
  });

  factory UsersInfoModel.fromJson(Map<String, dynamic> json) {
    return UsersInfoModel(
      uid: json['uid'],
      email: json['email'],
      fullName: json['fullName'],
      location: json['location'],
      age: json['age'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'location': location,
      'age': age,
      'createdAt': createdAt,
    };
  }
}
