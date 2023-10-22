import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manipal/HomeScreen.dart';
import 'package:manipal/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GetStarted.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of my application.
  String? rollnumber;
  String? visited;
  Future validate() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var user = sharedPreferences.getString('rollnumber');
    var visit = sharedPreferences.getString('visited');
    setState(() {
      rollnumber = user;
      visited = visit;
    });
  }

  @override
  void initState() {
    validate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutrient Tracker',
      theme: ThemeData(),
      home: rollnumber == null
          ? (visited == null ? const GetStarted() : const LoginScreen())
          : const HomeScreen(),
    );
  }
}



// otpLogin(
//           name: "Dddd",
//           age: "20",
//           number: "9814467960",
//           rollnumber: "Abhs",
//           password: "100%Darke",
//           otp: "12345"),