import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> saveUserData({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      await usersCollection.add({
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
      });

      // Data saved successfully
      Fluttertoast.showToast(msg: 'User data saved to Firestore');
    } catch (e) {
      print('Error saving user data: $e');
      // Handle errors
      Fluttertoast.showToast(
        msg: 'Error saving user data: $e',
        backgroundColor: Colors.red,
      );
    }
  }
}
Future<void> printUserData() async {
  try {
    QuerySnapshot querySnapshot = await usersCollection.get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print('User Data:');
      print('Username: ${data['username']}');
      print('Email: ${data['email']}');
      print('Password: ${data['password']}');
      print('Phone: ${data['phone']}');
      print('---');
    });
  } catch (e) {
    print('Error printing user data: $e');
  }
}
