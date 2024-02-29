/*
class UserRepo extends GetxController{
  static UserRepo get instance => Get.find();

  final _db = FirebasesFirestore.instance;

  createUser(UserModel user) async{
   await _db.collection("Users").add(user.toJson()).whenComplete(
        () => Get.snackbar("success","you account has been created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              coloText: Colors.greeen),
    )
        .catchError((error, stackTrace) {
          Get.snackbar("error","sometime went wrong. try again",
            snackPosition: SnackPosition.BOTTOM,
            backgrounColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red
              print("error-$error");
          );

    });

  }
}*/