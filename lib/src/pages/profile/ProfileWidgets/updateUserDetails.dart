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
     this.userName="",
     this.email="",
     this.phone="",
     this.password="",});
  @override
  State<updateUserDetails> createState() => _updateUserDetailsState();
}

class _updateUserDetailsState extends State<updateUserDetails> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final categoryController = SingleValueDropDownController();
  final serviceController = SingleValueDropDownController();
  TextEditingController exeperienceController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    print(widget.email);
    usernameController.text = widget.userName;
    emailController.text = widget.email;
    passwordController.text = widget.password;
    phoneController.text = widget.phone;
  }

  // Update user data in Firestore

  void update() async {
    if (validateFields()) {
      setState(() {
        isLoading = true;
      });

      CollectionReference collection;
    /*  if (categoryController.dropDownValue?.value == 'worker') {
        collection = FirebaseFirestore.instance.collection('workers');
      }
      else{
      }*/
      collection = FirebaseFirestore.instance.collection('users');


      await collection.doc(currentUser?.email).set({
        'username': usernameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'category': categoryController.dropDownValue?.value.toString(),
        'service': serviceController.dropDownValue?.value.toString(),
        'exeperienc': exeperienceController.text,
      });
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        isLoading = true;
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
    exeperienceController.text= '';
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
                        height:MediaQuery.of(context).size.height * 0.7,
                        padding: EdgeInsets.all(15.0),
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
                              dropDownList: const [
                                DropDownValueModel(name: 'client', value: 'client'),
                                DropDownValueModel(name: 'worker', value: 'worker'),
                              ],
                            ),

                            SizedBox(height: 15),
                            if (categoryController.dropDownValue?.value=='worker')

                            Column(
                              children: [
                                DropDownTextField(
                                                         textFieldDecoration: InputDecoration(hintText: "services"),
                                                           controller: serviceController,
                                                           dropDownItemCount: 6,
                                                           enableSearch: true,
                                 dropDownList: const [
                                                      DropDownValueModel(name: 'electician', value: "electician"),
                                                      DropDownValueModel(name: 'plumber', value: "plumber"),
                                                      DropDownValueModel(name: 'carpentar', value: "carpentar"),
                                                      DropDownValueModel(name: 'cook', value: "cook"),
                                                      DropDownValueModel(name: 'driver', value: "driver"),
                                                      DropDownValueModel(name: 'sweeper', value: "sweeper"),
                                                      DropDownValueModel(name: 'labour', value: "labour"),
                                                      DropDownValueModel(name: 'garderner', value: "garderner"),
                                                      DropDownValueModel(name: 'builder', value: "builder"),
                                                      DropDownValueModel(name: 'helper', value: "helper"),
                                                      DropDownValueModel(name: 'ironsmith', value: "ironsmith"),
                                                    ],
                                                  ),
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: 'Experience',
                                      hintText: 'experience'
                                  ),
                                  controller: exeperienceController,
                                ),
                              ],

                            ),





                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            Center(
                              child: TextButton(
                                onPressed: () async {
                                  update();
                                  Navigator.pop(context);
                                },
                                child: Text('Save',style:  TextStyle(
                                  fontSize: 20,
                                ),),
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
