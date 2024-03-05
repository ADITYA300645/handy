import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source:ImageSource.gallery);
  if(_file != null){
    return await _file.readAsBytes();

  }
  print('no image slected');

}