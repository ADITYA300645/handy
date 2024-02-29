import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';
import 'package:handy/src/pages/widgets/bottombar/CustomBottomBar.dart';


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
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50),
                                  image:DecorationImage(
                                    image: AssetImage('assets/photos/user.jpg'),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Card(
                                child: ListTile(
                                  subtitle: Text(userData['username']),
                                  title: Text(usernameController.text),
                                  leading: Icon(Icons.account_circle),
                                ),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                subtitle: Text(userData['email']),
                                title: Text(mailController.text),
                                leading: Icon(Icons.mail_outline_outlined),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                subtitle: Text(userData['phone']),
                                title: Text(contactNoController.text),
                                leading: Icon(Icons.phone_android_outlined),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                subtitle: Text('client'),
                                title: Text(classController.text),
                                leading: Icon(Icons.track_changes_rounded),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                subtitle: Text(userData['password']),
                                title: Text(passwordController.text),
                                leading: Icon(Icons.lock_open_rounded),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                subtitle: Text('Indian'),
                                title: Text(citizenController.text),
                                leading: Icon(Icons.flag_circle),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  // Reset the TextEditingController values
                                  usernameController.clear();
                                  mailController.clear();
                                  passwordController.clear();
                                  contactNoController.clear();
                                  classController.clear();
                                  citizenController.clear();

                                  // Show a custom-sized AlertDialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        // Set the desired width and height
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          height: 650,
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  DropDownValueModel(name: 'service provider', value: 'value'),
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              DropDownTextField(
                                                enableSearch: true,
                                                textFieldDecoration: InputDecoration(hintText: "Citizen"),
                                                dropDownList: const [
                                                  DropDownValueModel(name: 'Indian', value: ""),
                                                  DropDownValueModel(name: 'American', value: ""),
                                                  DropDownValueModel(name: 'Canadian', value: ""),
                                                  DropDownValueModel(name: 'Chinese', value: ""),
                                                  DropDownValueModel(name: 'Australian', value: ""),
                                                  DropDownValueModel(name: 'African', value: ""),
                                                  DropDownValueModel(name: 'Japanese', value: ""),
                                                  DropDownValueModel(name: 'Russian', value: ""),
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
                                    },
                                  );
                                },
                                child: Text('edit profile'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const CustomBottomBar(),
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

void main() {
  runApp(MaterialApp(
    home: Profile(),
  ));
}

/*/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This function updates the user profile data in Firestore
Future<void> updateUserProfileData(String userId, Map<String, dynamic> userData) async {
  try {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Update the user profile data
    await firestore.collection('users').doc(userId).update(userData);
  } catch (error) {
    print("Error updating user profile: $error");
    // Handle error accordingly
  }
}

// Widget where the dialog is shown
class ProfileEditorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController contactNoController = TextEditingController();

    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            // Other form fields...
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Center(
              child: TextButton(
                onPressed: () {
                  // Construct the user data to be updated
                  Map<String, dynamic> userData = {
                    'username': usernameController.text,
                    'mail': mailController.text,
                    'password': passwordController.text,
                    'contactNo': contactNoController.text,
                    // Add other fields as needed
                  };

                  // Assuming you have the user ID available, replace 'userId' with the actual user ID
                  String userId = 'userId';

                  // Call the function to update the user profile data
                  updateUserProfileData(userId, userData);

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
}

// Usage example:
// Call this function where you want to show the dialog
// For example, you can call it from a button's onPressed callback
void showProfileEditorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ProfileEditorDialog();
    },
  );
}
*/