
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../home/HomePage.dart';



class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {


  String phone = Get.arguments;
  String submitedOtp = "";
  String OTP = '';

  void OtpMatch(){
    print(submitedOtp);
    if(submitedOtp.isEmpty){
      Get.defaultDialog(
        buttonColor: Colors.black,
        radius: 30,
        textConfirm: 'ok',
        title: 'error',
        middleText: 'opt will not empty',
        onConfirm: ()=>Get.back(),
      );
    }
    else if(submitedOtp == OTP){
       Get.to(()=>HomePage());
    }
    else{
      Get.snackbar("Wrong Otp", "Please re-check the otp");
    }
  }

  void getOTP() {

// FirebaseAuth.instance.verifyPhoneNumber(
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       verificationFailed: (FirebaseAuthException ex) {},
//       codeSent: (String verificationId, int? resendToken) async {},
//       codeAutoRetrievalTimeout: (String verificationId) {},
//       phoneNumber: phone,
//     );

    FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential){},
      verificationFailed: (FirebaseAuthException ex){},
      codeSent: (String verificationId,int? resendToken)async{
        OTP  = '';
        print(OTP);
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: OTP);
      },
      codeAutoRetrievalTimeout: (String verificationId){},
      phoneNumber: phone,

    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration:  const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.71, -0.71),
                      end: Alignment(-0.71, 0.71),
                      colors:[
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 180),
                      child: Container(
                        height: 200,
                        width: 310,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300,width: 4),
                        ),
                        child: Center(
                          child: Text('Handy',style: TextStyle(
                              fontSize: 90,
                              color: Colors.deepPurple.shade900,
                              fontWeight: FontWeight.bold
                          )),
                        ),
                      ),
                    ),

                    OtpTextField(
                      clearText:true,
                      numberOfFields: 6,
                      borderColor: Color(0xFF512DA8),
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      onSubmit: (val)=>submitedOtp=val,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 220,top: 25),
                child: InkWell(
                  onTap: () {
                    getOTP();
                    print(phone);
                  },
                  child: Text('click here for the otp',style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,

                  ),),
                ),
              ),

              SizedBox(height: 30,),

              InkWell(
                onTap: ()
                {
                  OtpMatch();
                 },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('submit',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
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

