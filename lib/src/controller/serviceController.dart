import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:handy/src/pages/Client/SearchJobs/JobSearch.dart';

class ServiceController extends GetxController{
  var selectedService ="".obs;


  void updateSelectedService(String value){
    selectedService.value = value;
  }


  void fetchCurrentUserDetails() {
    final currentUserID = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('users').doc(currentUserID?.email).get().then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        // Explicitly cast the return value of docSnapshot.data() to Map<String, dynamic>
        Map<String, dynamic>? userData = docSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          // Accessing the username field from the userData map
          String? username = userData['username'];
          String? email = userData['email'];
          String? phone = userData['phone'];
          String? photoURL = userData['photoURL'];


          if (username != null) {
            print('MY Username: $username');

            // Handle the user data here
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

/*  final workersStream = FirebaseFirestore.instance.collection('workers').snapshots();
    final userStream = FirebaseFirestore.instance.collection('users').doc(currentUser?.email).snapshots();
    final mergedStream = StreamGroup.merge([workersStream, userStream]);
    mergedStream,
    */