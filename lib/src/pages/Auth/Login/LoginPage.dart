import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:handy/src/pages/Auth/Login/googleauth.dart';
import 'package:handy/src/pages/Auth/SignUp/SignUpPage.dart';
import 'package:handy/src/pages/home/HomePage.dart';
import 'package:handy/src/pages/profile/ProfileWidgets/EditImage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;

  bool _validateInput() {

    if (
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty
      ) {
      Get.snackbar(
        "error",
        "all fields required",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );

      return false;
    }
    if (_emailController.text.length<7){
      Get.snackbar(
        "error",
        'Password must be at least 7 characters long',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }

    if (!GetUtils.isEmail(_emailController.text)) {
      Get.snackbar(
        'error',
        'invaild mail format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void SignInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email: _emailController.text,
        password: _passwordController.text,
      );

      FirebaseAuth.instance
          .userChanges()
          .listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });

      // If successful, you can access the user via userCredential.user
      User? user = userCredential.user;
      if (user != null) {
        Get.snackbar(
          'Success',
          'Signed in successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.lightBlueAccent,
          colorText: Colors.white,
        );
        Get.off(HomePage());

        // You can proceed with further actions after successful sign-in
      }


      
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Failed to sign in. Please check your credentials.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If user is already authenticated, navigate to home page
      return HomePage();
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.home),
      //   onPressed: () =>
      //      Get.off(HomePage())
      // ),

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
                      end: Alignment(-0.71, 0.71),
                      colors: [
                        Color(0xFFFFD6FF),
                        Color(0xFFB8C0FF),
                        Color(0xFFE7C6FF),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery
                .of(context)
                .size
                .height / 2.75,
            child: Card(
              borderOnForeground: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 21,
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(63, 78, 114, 1)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: "email/username",
                            suffixIcon: Icon(Icons.account_circle)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            hintText: "password",
                            suffix: IconButton(
                              icon: isVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.snackbar(
                            "now",
                            'create new account',
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                        child: Text('forgot password'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 1),
                      child: Center(
                        child: InkWell(
                          onTap: (){

                            if(_validateInput()){


                              SignInWithEmailAndPassword();

                            }

                          },
                          child: Card(
                            color: Colors.blue,
                            child: Container(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 15),
                                child: Text("Done",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),


                    Center(
                      child: Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.2),

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
                  ],
                ),
              ),
            ),
          ),
           Padding(
             padding: const EdgeInsets.only(top: 750,left: 80),
             child: Row(
                  children: [
                    const Text("Don't have an Account ? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
           ),
        ],
      ),
    );
  }
}

