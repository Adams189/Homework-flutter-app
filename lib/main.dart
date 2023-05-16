import 'package:flutter/material.dart';
import 'package:homework/screens/bottom_navigation_screens/categories_screen.dart';
import 'package:homework/screens/bottom_navigation_screens/home_screen.dart';
import 'package:homework/screens/homescreens/assignments_screen.dart';
import 'package:homework/screens/homescreens/post_assignment_screen.dart';
import 'package:homework/screens/login_screen.dart';
import 'package:homework/screens/bottom_navigation_screens/profile_screen.dart';
import 'package:homework/screens/registration_screen.dart';
import 'package:homework/screens/homescreens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homework/screens/bottom_navigation_screens/deals_screen.dart';

Future <void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.green,

      ),
      initialRoute: LoginScreen.id,
      routes: {
      LoginScreen.id: (context)=> LoginScreen(),
        HomeScreen.id: (context)=> HomeScreen(),
        RegistrationScreen.id: (context)=> RegistrationScreen(),
        WelcomeScreen.id : (context)=> WelcomeScreen(),
        ProfileScreen.id : (context)=> ProfileScreen(),
        DealScreen.id : (context)=> DealScreen(),
        CategoriesScreen.id : (context)=> CategoriesScreen(),
        Post_Assignment.id : (context)=> Post_Assignment(),
        Assignments.id : (context)=> Assignments(),

      },
    );
  }
}
