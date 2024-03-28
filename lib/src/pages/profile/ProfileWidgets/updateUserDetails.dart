import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class updateUserDetails extends StatefulWidget {
  String userName;
  String email;
  String phone;
  String password;
  updateUserDetails({ super.key,
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,});
  @override
  State<updateUserDetails> createState() => _updateUserDetailsState();
}

class _updateUserDetailsState extends State<updateUserDetails> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final categoryController = SingleValueDropDownController();
  final jobController = SingleValueDropDownController();


  TextEditingController citizenController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    print(widget.email);
    usernameController.text = widget.userName;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    passwordController.text = widget.password;
  }

  // Update user data in Firestore

  void update() async {
    if (validateFields()) {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance.collection('users').doc(currentUser?.email).update({
        'username': usernameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'category': categoryController.dropDownValue?.value.toString()
      });
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });
    }
  }

  bool validateFields() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      Get.snackbar(
        "error",
        "all fields required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void setVal(){
    usernameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    phoneController.text = "";
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
                  return Expanded(
                    child: Dialog(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height:MediaQuery.of(context).size.height * 0.6,
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
                              controller: categoryController,
                              textFieldDecoration: InputDecoration(
                                hintText: 'Category',
                              ),
                              clearOption: true,
                              dropDownItemCount: 6,
                              dropDownList: const [
                                DropDownValueModel(name: 'client', value: 'client'),
                                DropDownValueModel(name: 'worker', value: 'worker'),
                              ],
                            ),
                            SizedBox(height: 15),
                            if (categoryController.dropDownValue?.value=='worker')
                         DropDownTextField(
                         textFieldDecoration: InputDecoration(hintText: "services"),
                         enableSearch: true,
                             dropDownList: const [
                      DropDownValueModel(name: 'electician', value: ""),
                      DropDownValueModel(name: 'plumber', value: ""),
                      DropDownValueModel(name: 'carpentar', value: ""),
                      DropDownValueModel(name: 'cook', value: ""),
                      DropDownValueModel(name: 'driver', value: ""),
                      DropDownValueModel(name: 'sweeper', value: ""),
                      DropDownValueModel(name: 'labour', value: ""),
                      DropDownValueModel(name: 'garderner', value: ""),
                      DropDownValueModel(name: 'builder', value: ""),
                      DropDownValueModel(name: 'helper', value: ""),
                      DropDownValueModel(name: 'ironsmith', value: ""),

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
                    ),
                  );
                }
            );

          },

            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]
              ),
              child: Center(child: Text('edit profile',style: TextStyle(
                fontSize: 10,
              ),)),
            ),

        ),
      ],
    );

  }
}
