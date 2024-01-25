import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';  // Make sure this import is present
import 'package:get/get.dart';  // Make sure this import is present
import 'package:handy/pages/home/HomePage.dart';  // Adjust imports based on your project structure
import 'package:handy/pages/profile/Profile.dart';
import 'package:handy/pages/Auth/Login/googleauth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  Future<void> _saveUserData() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone': _phoneController.text,
      });

      // Data saved successfully
      Fluttertoast.showToast(msg: 'User data saved to Firestore');
    } catch (e) {
      print('Error saving user data: $e');
      // Handle errors
      Fluttertoast.showToast(msg: 'Error saving user data: $e', backgroundColor: Colors.red);
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  bool _validateInput() {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _rePasswordController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      _showErrorDialog("All fields are required");
      return false;
    }

    if (!GetUtils.isEmail(_emailController.text)) {
      _showErrorDialog("Invalid email format");
      return false;
    }

    if (_passwordController.text != _rePasswordController.text) {
      _showErrorDialog("Passwords do not match");
      return false;
    }

    _saveUserData(); // Save data if all validations pass
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.71, -0.71),
                    end: Alignment(-0.71, -0.71),
                    colors: [
                      Color(0xFFFDD6FF),
                      Color(0xDDDDD6FF),
                      Color(0xDDDDD6FF),
                    ],
                  ),
                )),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.95,
            child: Card(
              borderOnForeground: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 21,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.6,
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Text(
                          "Sign-in",
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(63, 78, 114, 1)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 7),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            hintText: "username",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: "email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: "password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: _rePasswordController,
                        decoration: const InputDecoration(
                          hintText: "re-password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          hintText: "phone",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                           if (_validateInput()) {
                             // Navigate to HomePage when the "Done" button is tapped
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => HomePage(),
                               ),
                             );
                           }
                          },
                          child: Card(
                            color: Colors.blue,
                            child: Container(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 15),
                                child: Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: const[
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        child: ElevatedButton(onPressed: () => AuthService().signInWithGoogle(),
                            child: Text('login with google')),
                      ),
                    )
                  ],
                ),
              ),

            ),

          ),
        ],
      ),
    );
  }
}
