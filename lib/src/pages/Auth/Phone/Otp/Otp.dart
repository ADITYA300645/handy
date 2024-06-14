import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:handy/src/pages/home/HomePage.dart';
import 'package:http/http.dart';


class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
 /* OtpFieldController otpController = OtpFieldController();
  String phone = Get.arguments;
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OtpTextField(
            clearText:true,
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  }
              );
            }, // end onSubmit
          ),
        ],
      ),


    );
  }
}

void OtpMatch(String enteredPin, String smsCode) {
  // Check if the first 5 characters of the entered PIN match smsCode
  if (enteredPin.substring(0, 5) == smsCode.substring(0, 5)) {
    // Navigate to the home screen here
    Get.to(()=>HomePage());
    if(enteredPin != ""){
      Get.defaultDialog(title: "errror",middleText: 'opt is not provided',textConfirm: 'ok',onConfirm: () => Get.back(),);
    }
  }
}
