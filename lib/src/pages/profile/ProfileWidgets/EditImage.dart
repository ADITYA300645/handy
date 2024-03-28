import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class EditImage extends StatefulWidget {
  const EditImage({Key? key}) : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  File? selectedImage;
  String base64Image = "";

  Future<void> chooseImage(type) async {
    var image;
    if (type == "Gallery") {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
      final fileName = DateTime.now().toString() + image.path.split('/').last;
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref(currentUser!.email)
          .child('images/$fileName');
      await storageRef.putFile(File(image.path));
      // Get the download URL
      final url = await storageRef.getDownloadURL();
      // Use the download URL as needed
      print('Image URL: $url');
      // Save the download URL to Firestore
      saveImageUrlToFirestore(url);

    }
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
          .update({"photoURL": imageUrl});
      // Fetch the updated user data from Firebase Authentication
      print('Image URL saved to Firestore');
      await currentUser!.reload();
    } catch (error) {
      print('Error saving image URL: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    currentUser!.reload();
    (currentUser!.printInfo());
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              selectedImage != null
                  ? Container(
                height: 130,
                width: 135,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(80),
                  image: DecorationImage(
                    image: FileImage(selectedImage!),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              )
                  : StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users')
                    .doc(currentUser?.email).snapshots(),
                    builder:(context, snapshot) {
                      final userData = snapshot.data!.data() as Map<String,dynamic>;
                      return snapshot.hasData ? Container(
                                    height: 155,
                                    width: 155,
                                    decoration: BoxDecoration(
                                     // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.all(Radius.circular(6777)),
                                      color: Colors.blue,
                                    ),
                                    child: ClipOval(

                                      child: Image.network(userData["photoURL"],fit: BoxFit.cover,
                                      ),
                                    ),
                                  ) : Container();
                    }
                  ) ,
              Positioned(
                top: 120,
                left: 90,
                child: InkWell(
                  onTap: () async {
                    CustomUserImage(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xff200A36),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_a_photo,
                      color: Color(0xffffffff),
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void CustomUserImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => chooseImage('Gallery'),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.grey.shade500,
                            size: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                InkWell(
                  onTap: () => chooseImage('camera'),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 180),
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.grey.shade500,
                              size: 45,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
