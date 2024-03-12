import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class EditImage extends StatefulWidget {
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {

  File? seledtedImage;
  String base64Image = "";

  Future<void>chooseImage(type) async{
    var image;

    if(type=="camera"){
      image=await ImagePicker().pickImage(source: ImageSource.camera);
    }else{
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if(image != null){
      setState(() {
        seledtedImage = File(image.path);
        base64Image = base64Encode(seledtedImage!.readAsBytesSync());
      });
    }
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


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              seledtedImage != null
                  ? Container(
                height: 130,
                width: 135,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(80),
                  image: DecorationImage(
                      image: FileImage(
                        seledtedImage!,
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment
                          .topCenter),
                ),
              )
                  : Container(
                height: 130,
                width: 135,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
              Positioned(
                top: 100,
                left: 80,
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
}


