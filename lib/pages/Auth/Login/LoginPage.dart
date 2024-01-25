import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/pages/Auth/Login/googleauth.dart';
import 'package:handy/pages/Auth/SignUp/SignUpPage.dart';
import 'package:handy/pages/home/HomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('Sign-in successful! User UID: ${userCredential.user!.uid}');
      // Retrieve user data from Firestore
      // Note: Replace 'users' with your Firestore collection name
      var userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      // You can access user data like this
      String username = userDocument['username'];
      print(username);
      String email = userDocument['email'];
      String password = userDocument['password'];
      String phone = userDocument['phone'];
      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    on FirebaseAuthException catch (e) {
      print('Failed to sign in: $e');
      Fluttertoast.showToast(
        msg: 'Failed: inputs not match',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),)),),
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
            top: MediaQuery.of(context).size.height / 2.75,
            child: Card(
              borderOnForeground: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 21,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.0,
                width: MediaQuery.of(context).size.width - 60,
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
                          onPressed: (){},
                          child: Text('forgot password'),
                          ),
                        ),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 1),
                      child: Center(
                        child: InkWell(
                          onTap: _signInWithEmailAndPassword,
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

                  /* Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       const Text('or'),
                       SizedBox(
                         width: double.infinity,
                         child: OutlinedButton.icon(
                             onPressed:(){},
                             icon: Image(image: AssetImage('assets/photos/googleLogo.png'),
                             fit: BoxFit.cover,
                             ),
                             label: Text('google with login'),
                         ),
                       )
                     ],
                   ),*/


                   Center(
                      child: TextButton(
                        onPressed: () async {
                              await AuthService().signInWithGoogle();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                            },
                          child: Text('login with google'),

                          ),
                        ),


                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
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
          )
        ],
      ),
    );
  }
}



