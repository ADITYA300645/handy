import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class updateUserDetails extends StatefulWidget {
  const updateUserDetails({super.key});
  @override
  State<updateUserDetails> createState() => _updateUserDetailsState();
}

class _updateUserDetailsState extends State<updateUserDetails> {
  final usernameController = TextEditingController(text:'sagar');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController citizenController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;


  // Update user data in Firestore

  void update() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users')
        .doc(currentUser?.email).
    update({
      'username': usernameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
      'category': categoryController.text
    });
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        InkWell(
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return Dialog(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height:MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'username',
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Mail',
                              hintText: 'mail'
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'password'
                            ),
                          ),
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Contact No.',
                              hintText: 'contact no.'
                            ),
                          ),
                          SizedBox(height: 15),
                          DropDownTextField(
                            textFieldDecoration: InputDecoration(
                              hintText: 'Category',
                            ),
                            clearOption: true,
                            dropDownItemCount: 6,
                            dropDownList: const [
                              DropDownValueModel(name: 'client', value: 'value'),
                              DropDownValueModel(name: 'worker', value: 'value'),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          Center(
                            child: TextButton(
                              onPressed: () async {
                                update();
                                Navigator.pop(context);
                              },
                              child: Text('Save'),
                            ),
                          ),

                        ],
                      ),

                    ),
                  );
                }
            );

          },
          child: Container(
            height: 60,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ]
            ),
            child: Center(child: Text('edit profile',style: TextStyle(
              fontSize: 20,
            ),)),
          ),
        ),
      ],
    );

  }
}
