import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/src/controller/serviceController.dart';
import 'package:handy/src/pages/Service/Service2.dart';
import 'package:handy/src/pages/widgets/appbar/SimpleAppBar.dart';
import 'package:handy/src/pages/widgets/bottombar/CustomBottomBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServiceState();
}

class _ServiceState extends State<ServicePage> {
  final serviceController = Get.put(ServiceController(),permanent: true);
  final TextEditingController optionalController = TextEditingController();
  final dropDownServiceController = SingleValueDropDownController();

  void PushJobPostData() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String? email = currentUser.email;

      FirebaseFirestore.instance
          .collection('users')
          .doc(email) // Assuming the user identifier is the document ID
          .get()
          .then((DocumentSnapshot docSnapshot) {
        if (docSnapshot.exists) {
          // Explicitly cast the return value of docSnapshot.data() to Map<String, dynamic>
          Map<String, dynamic>? userData =
          docSnapshot.data() as Map<String, dynamic>?;

          if (userData != null) {
            // Accessing the username field from the userData map
            String? username = userData['username'];
            String? phone = userData['phone'];
            String? photoURL = userData['photoURL'];
            print(photoURL);


            if (username != null) {
              print('ok report data is fetching');
              // Add data to "job post" collection along with user details
              FirebaseFirestore.instance.collection('job post').add({
                'username':username,
                'email': email,
                'phone': phone,
                'photoURL':photoURL,
                'optional':optionalController.text,
                'service': dropDownServiceController.dropDownValue?.value.toString(),
                'timestamp': Timestamp.now(),
              }).then((value) {
                // Data successfully saved
                print("Data added to Firestore!");
              }).catchError((error) {
                // Handle errors
                print("Failed to add data: $error");
              });
            } else {
              print('Username field is null');
            }
          } else {
            print('User data map is null');
          }
        } else {
          print('Document does not exist');
        }
      }).catchError((error) {
        print('Failed to fetch user: $error');
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  SimpleAppBar(pageTitle: 'Service',),
      body:  SingleChildScrollView(
        child: Column(
                children: [
                  SizedBox(
                    child: CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/labour4.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/construction2.jpg'),
                              fit: BoxFit.cover,
        
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/carpenter3.jpg'),
                              fit: BoxFit.cover,
        
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/electrician.jpg'),
                              fit: BoxFit.cover,
        
                            ),
                          ),
                        ),
        
                      ],
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 10/9,
                        viewportFraction: 1,
                        initialPage: 4,
                        enableInfiniteScroll: true,
                        reverse: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.linear,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
        
        
        
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Tell us what are you looking for........?',style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
        
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
        
                  Container(
                    height:40,
                    width: 380,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: SingleChildScrollView(
                      child: DropDownTextField(
                        controller: dropDownServiceController,
                        textFieldDecoration: InputDecoration(hintText: " Services"),
                        enableSearch: true,
                        dropDownList: const [
                          DropDownValueModel(name: 'electrician', value: "electrician"),
                          DropDownValueModel(name: 'plumber', value: "plumber"),
                          DropDownValueModel(name: 'carpenter', value: "carpenter"),
                          DropDownValueModel(name: 'chef', value: "chef"),
                          DropDownValueModel(name: 'driver', value: "driver"),
                          DropDownValueModel(name: 'sweeper', value: "sweeper"),
                          DropDownValueModel(name: 'labour', value: "labour"),
                          DropDownValueModel(name: 'garderner', value: "garderner"),
                          DropDownValueModel(name: 'builder', value: "builder"),
                          DropDownValueModel(name: 'helper', value: "garderner"),
                          DropDownValueModel(name: 'ironsmith', value: "ironsmith"),
                        ],
                        onChanged: (value){
                            print(value.name);
                            serviceController.selectedService.value = value.name.toString();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Container(
                    height: 40,
                    width: 380,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextField(
                      controller: optionalController,
                      decoration: InputDecoration(
                        hintText: " Descripition(optional)",
                      ),
                    ),
                  ),
        
                  SizedBox(height: MediaQuery.of(context).size.height*0.06),
        
                  ElevatedButton(
                    onPressed: ()  async {
                       Get.to(()=>Service2(),arguments: serviceController.selectedService.value);
                       PushJobPostData();
                       },
        
                    style: ElevatedButton.styleFrom(
                       // Set the background color
                      backgroundColor: Colors.redAccent ,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        // Set the border radius
                      ),
                      minimumSize: Size(290, 50), // Set the width and height
                    ),
                    child: Text(
                      'Lets go!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set the text color
                      ),
                    ),
                  ),
        
                  SizedBox(height: MediaQuery.of(context).size.height*0.04),
        
                  Text('☑️Browse profiles,ratings and portfolios',style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                  Text('☑️Contact skilled person within minutes',style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
        
                  Text('☑️Pay only when you are 100% satisfied',style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
        
                  Padding(
                    padding: const EdgeInsets.only(top: 36),
                    child: CustomBottomBar(),
                  )
        
        
                ],
        
              ),
      ),

    );
  }
}

