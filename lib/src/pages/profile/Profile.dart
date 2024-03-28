import 'package:handy/src/pages/profile/ProfileWidgets/EditImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handy/src/pages/profile/ProfileWidgets/updateUserDetails.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';
import 'package:handy/src/pages/widgets/bottombar/CustomBottomBar.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController categoryController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users')
              .doc(currentUser?.email).snapshots(),
          builder: (context, snapshort){

            if(snapshort.hasData){

              final userData = snapshort.data!.data() as Map<String,dynamic>;
              print(userData);
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    const [CustomAppbar(pageTitle: 'Profile',barHeight: 120,)],
                    body: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            EditImage(),
                            ListTile(
                              title: Text('Username'),
                              subtitle: Text(userData['username']),
                              leading: Icon(Icons.account_circle),
                            ),
                            Divider(height: 2,),
                            ListTile(
                              title: Text('email'),
                              subtitle: Text(userData['email']),
                              leading: Icon(Icons.email),
                            ),
                            Divider(height: 1,),
                            ListTile(
                              title: Text('location'),
                              subtitle: Text('Delhi Lajpat Nagar'),
                              leading: Icon(Icons.location_on_sharp),
                            ),
                            Divider(height: 1,),
                            ListTile(
                              title: Text('phone'),
                              subtitle: Text(userData['phone']),
                              leading: Icon(Icons.phone),
                            ),
                            Divider(height: 1,),
                            ListTile(
                              title: Text('password'),
                              subtitle: Text(userData['password']),
                              leading: Icon(Icons.lock),
                            ),
                            Divider(height: 1,),


                            ListTile(
                              title: Text('category'),
                              subtitle: Text(userData['category']),
                              leading: Icon(Icons.category),
                            ),
                            Divider(height: 1,),



                            updateUserDetails(
                              userName: userData["username"],
                              password: userData["password"],
                              phone: userData["phone"],
                              email: userData["email"],
                            ),

                          ],
                        ),
                        const  CustomBottomBar(),
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
