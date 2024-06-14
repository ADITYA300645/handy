import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:handy/src/pages/profile/ProfileWidgets/EditImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handy/src/pages/profile/ProfileWidgets/updateUserDetails.dart';
import 'package:handy/src/pages/widgets/appbar/SimpleAppBar.dart';
import 'package:handy/src/pages/widgets/bottombar/CustomBottomBar.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final currentUser = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> _dataFromUsersCollection = [];
  List<DocumentSnapshot> _dataFromWorkersCollection = [];

  Future<void> _getDataFromCollection1() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .get();
    setState(() {
      _dataFromUsersCollection = querySnapshot.docs;
    });
  }

  Future<void> _getDataFromCollection2() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore
        .instance
        .collection('workers')
        .get();
    setState(() {
      _dataFromWorkersCollection = querySnapshot.docs;
    });
  }

  Future<void> _combineData() async{
    await Future.wait([_getDataFromCollection1(), _getDataFromCollection2()]);
    List<Map<String, dynamic>> combinedData = [];
    _dataFromUsersCollection.forEach((doc) {
      combinedData.add({'username': doc['username'], 'email': doc['email']});
    });
    _dataFromWorkersCollection.forEach((doc) {
      combinedData.add({'username': doc['username'], 'email': doc['email']});
    });
    // Now `combinedData` contains data from both collections
    print(combinedData);
    print(combinedData); // You can use the combined data here or set it to a variable
  }

  @override
  void initState(){
    super.initState();
    _combineData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(pageTitle: 'profile'),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final userDataRaw = snapshot.data!.data();
            if (userDataRaw != null) {
              var userData = userDataRaw as Map<String, dynamic>;
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                   SingleChildScrollView(
                     scrollDirection:  Axis.vertical,
                     child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const EditImage(),
                            ListTile(
                              title: const Text('username'),
                              subtitle: Text(userData['username'] ?? "username"),
                              leading: const Icon(Icons.account_circle),
                            ),
                            const Divider(height: 2),
                            ListTile(
                              title: const Text('email'),
                              subtitle: Text(userData['email'] ?? "email"),
                              leading: const Icon(Icons.email),
                            ),
                            const Divider(height: 1),
                            const ListTile(
                              title: Text('location'),
                              subtitle: Text('Delhi Lajpat Nagar'),
                              leading: Icon(Icons.location_on_sharp),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('phone'),
                              subtitle: Text(userData['phone'] ?? "phone No."),
                              leading: const Icon(Icons.phone),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('password'),
                              subtitle: Text("*******"),
                              leading: const Icon(Icons.lock),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: const Text('category'),
                              subtitle: Text(userData['category'] ?? "select category"),
                              leading: const Icon(Icons.category),
                            ),
                            const Divider(height: 1),
                            if (userData['category'] == "worker")
                              ListTile(
                                title: const Text("service"),
                                subtitle: Text(userData['service'] ?? "select work"),
                                leading: const Icon(Icons.shopping_bag_outlined),
                              ),
                            const Divider(height: 1),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            if(userData['service'] != null )
                            ListTile(
                              title: const Text("experience"),
                              subtitle: Text(userData['exeperienc'] ?? "choose year"),
                              leading: const Icon(Icons.timelapse),
                            ),

                            const SizedBox(height: 10),


                            Padding(
                              padding: const EdgeInsets.only(bottom: 90),
                              child: updateUserDetails(
                                userName: userData["username"],
                                password: userData["password"],
                                phone: userData["phone"],
                                email: userData["email"],
                              ),
                            ),
                          ],
                        ),
                   ),


                  CustomBottomBar(),
                ],
              );
            } else {
              return Center(
                child: Text('No data found'),
              );
            }
          } else {
            return Container(); // Placeholder
          }
        },
      ),
    );

  }

}

