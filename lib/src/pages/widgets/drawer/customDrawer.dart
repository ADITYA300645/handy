import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/src/pages/Auth/Login/LoginPage.dart';
import 'package:handy/src/pages/Credits/CreditsPage.dart';
import 'package:handy/src/pages/About/AboutPage.dart';
import 'package:handy/Theme/ThemePage.dart';
import 'package:handy/src/pages/profile/Profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key});


  void logOut(){
     FirebaseAuth.instance.signOut();
     Get.offAll(LoginPage());
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.only(bottom:60),
        width: 260,// Adjust the fraction as needed
        child: Drawer(
          shadowColor: Colors.grey,
          elevation: 5,
          child: ListView(
            children: [
              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile() ),
                  );
                },
              ),
              ListTile(
                title: Text("Credits"),
                leading: Icon(Icons.money),
                onTap: () {
                  print("Click");
                  Navigator.push(
                      context,
                    MaterialPageRoute(
                      builder: (context) => CreditsPage()
                  ),
                  );
                },
              ),
              ListTile(
                title: Text("Themes"),
                leading: Icon(Icons.add_circle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThemePage()
                  ),
                  );
                },
              ),
              ListTile(
                title: Text("About"),
                leading: Icon(Icons.account_tree_outlined),
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>AboutPage()
                  ),
                );
                },
              ),
              ListTile(
                title: Text("License"),
                leading: Icon(Icons.local_police_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LicensePage()
                  ),
                  );
                },
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.output),
                onTap: ()  {
                  logOut();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
