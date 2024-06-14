import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:handy/src/pages/Auth/Phone/Otp/Otp.dart';
import 'package:handy/src/pages/Auth/Phone/PhoneVerification.dart';
import 'package:handy/src/pages/home/HomePage.dart';
import 'package:handy/src/pages/Auth/Login/googleauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final TextEditingController _phoneController = TextEditingController(text: '+91');


  bool _validateInput() {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _rePasswordController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      Get.snackbar(
          "error",
          "all fields required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
      );

      return false;
    }

    if (!GetUtils.isEmail(_emailController.text)) {
      Get.snackbar(
          'error',
        'invaild mail format',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
          colorText: Colors.white,
      );
      return false;
    }



    if (_passwordController.text != _rePasswordController.text) {
      Get.snackbar(
        'error',
        'password not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );      return false;
    }
    if (_passwordController.text.length < 7) {
      Get.snackbar(
        'error',
        'Password must be at least 7 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }



    if(!GetUtils.isPhoneNumber(_phoneController.text)){
      Get.snackbar(
          'error',
        'check the number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
    else {
      Get.snackbar('Welcome', 'Registration successful');
    }

    return true;
  }

  void createUser() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      FirebaseFirestore.instance.collection('users')
          .doc(userCredential.user!.email)
          .set({
        'username':_usernameController.text,
        'email':_emailController.text,
        'password':_passwordController.text,
        'phone': _phoneController.text,

      });

      // If successful, you can access the user via userCredential.user
      User? user = userCredential.user;
      // if (user != null) {
      //   Get.snackbar(
      //     'now',
      //     'user created',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.greenAccent,
      //     colorText: Colors.white,
      //   );
      //   // You can save additional user data to Firestore or Realtime Database here
      // }
    } catch (e) {
      Get.snackbar(
        'failed',
        'to create user',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );    }
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
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            hintText: "username",
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
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
                          horizontal: 20.0, vertical: 1),
                      child: Center(
                        child: InkWell(
                          onTap: () {

                           if (_validateInput()) {
                             createUser();
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

                    Center(
                      child: GestureDetector(
                        onTap: () async {
                         // await signInWithGoogle();
                          signInWithGoogle();
                          Get.to(()=>HomePage());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                bool isSignedIn = (await signInWithGoogle()) as bool;
                                if (isSignedIn) {
                                  Get.to(() =>HomePage());
                                }else{
                                  print('unable to login');
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height:MediaQuery.of(context).size.width*0.07,
                                    width: MediaQuery.of(context).size.width*0.07,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/photos/googleLogo.png'),
                                        fit:  BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                  Text('login with google'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
