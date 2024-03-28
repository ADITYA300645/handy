import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/src/Splash/Splash.dart';
import 'package:handy/src/pages/controllers/JWTController/JWTController.dart';
import 'package:handy/Theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //Initilize Firebase
  final appDoc = await getApplicationDocumentsDirectory();
  Hive.init(appDoc.path);
  await Hive.openBox("secrets");
  await Hive.openBox("data");

  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user != null) {
      print(user.uid);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var jwtController = Get.put(JWTController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Handy',
      theme: lightTheme,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
