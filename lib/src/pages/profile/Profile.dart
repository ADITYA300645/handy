import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handy/src/pages/profile/EditImage.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';
import 'package:image_picker/image_picker.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController citizenController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;


  Widget buildCurvedContainer(
      double width, double height, double borderRadius, EdgeInsets margin) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.grey,
      ),
      margin: margin,
    );
  }
  Uint8List? _image;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users')
              .doc(currentUser?.email).snapshots(),
          builder: (context, snapshort){
            if(snapshort.hasData){
              final userData = snapshort.data!.data() as Map<String,dynamic>;

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    const [CustomAppbar(pageTitle: 'Profile',barHeight: 140,)],
                    body: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          /*  Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image:DecorationImage(
                                    image: AssetImage('assets/photos/user3.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade100,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  )
                                ]
                              ),

                              child: Padding(
                                padding: const EdgeInsets.only(top:75,left: 80),
                                    child:IconButton(
                                      onPressed: (){

                                      },
                                      icon: const Icon(Icons.add_a_photo,color: Colors.indigo),
                                    ),
                              ),
                            ),*/
                            Stack(
                              children: [
                                _image != null?
                                    CircleAvatar(
                                      radius: 64,
                                      backgroundImage: MemoryImage(_image!),
                                    ):

                                const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: AssetImage('assets/photos/user3.jpg'),
                                ),

                                Positioned(child: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.add_a_photo),
                                ),
                                  bottom: -10,
                                  left: 80,
                                )
                              ],
                            ),

                            ListTile(
                              title: Text('Username'),
                              subtitle: Text(userData['username']),
                              leading: Icon(Icons.account_circle),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('email'),
                              subtitle: Text(userData['email']),
                              leading: Icon(Icons.email),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('Location'),
                              subtitle: Text('Delhi Lajpat Nagar'),
                              leading: Icon(Icons.location_on_sharp),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('phone'),
                              subtitle: Text(userData['phone']),
                              leading: Icon(Icons.phone),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('password'),
                              subtitle: Text(userData['password']),
                              leading: Icon(Icons.lock),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('category'),
                              subtitle: Text('user'),
                              leading: Icon(Icons.category),
                            ),


                            InkWell(
                              onTap: (){
                                usernameController.clear();
                                mailController.clear();
                                passwordController.clear();
                                contactNoController.clear();
                                classController.clear();
                                citizenController.clear();
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
                                                ),
                                              ),
                                              TextField(
                                                controller: mailController,
                                                decoration: InputDecoration(
                                                  labelText: 'Mail',
                                                ),
                                              ),
                                              TextField(
                                                controller: passwordController,
                                                decoration: InputDecoration(
                                                  labelText: 'Password',
                                                ),
                                              ),
                                              TextField(
                                                controller: contactNoController,
                                                decoration: InputDecoration(
                                                  labelText: 'Contact No.',
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
                                              onPressed: () {
                                                setState(() {
                                                  // Update the card details with new values
                                                  // You can add more logic or validations here if needed
                                                });
                                                Navigator.pop(context); // Close the dialog
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
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }else if(snapshort.hasError){
              return Center(child: Text('error${snapshort.error}'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),

    );
  }

}

/*void showImagePicker(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/12,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pickImage(ImageSource.gallery);

                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 40,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 40,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
*/