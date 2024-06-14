

/*void saveDataToFirestore() async {
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
                'email': email,
                'phone': phone,
                'photoURL':photoURL,
                'username':username,
                'timestamp': Timestamp.now(), // Add timestamp for when the data was added
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
*/