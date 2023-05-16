import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework/components/user_model.dart';
import 'package:homework/screens/homescreens/assignments_screen.dart';
import 'package:homework/screens/homescreens/post_assignment_screen.dart';
import 'package:homework/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/gesturecards.dart';
import '../../constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final  searchController = TextEditingController();

class HomeScreen extends StatefulWidget {
  static const String id = 'homeRoute';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final searchField = TextFormField(
    autofocus: false,
    controller: searchController,
    keyboardType: TextInputType.text,
    // validator: (value){},
    onSaved: (value){
      searchController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration:  kEmailTextFeildDecoration.copyWith(
        hintText: 'Search for Assignment',
        prefixIcon: Icon(Icons.search, color: Colors.blue,))
);

class _HomeScreenState extends State<HomeScreen> {


  UserModel loggedInUser = UserModel();
  
  Future getUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    FirebaseFirestore.instance
        .collection('users')
        .doc(_preferences.getString("user_id"))
        .get()
        .then((value) => {
      loggedInUser = UserModel.fromMap(value.data()),
      setState((){})
    });
  }

  void removePreference () async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("user_id");
  }


  //Lets create an initial State
  @override
  void initState(){
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('WELCOME BACK'),
            WavyAnimatedText('LET US HELP YOU'),
            WavyAnimatedText('WELCOME BACK'),
          ],
        ),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: ActionChip(label: Text('LogOut'),
          onPressed: (){
            removePreference();
            logOut(context);
          },
      ),
        ),],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [


          Text('Hi ${loggedInUser.firstName}',style:
            kTextStlye.copyWith(fontSize: 20),),
          SizedBox(height: 10,),
          searchField,
              myCards(title: 'Assignments', icon: Icons.add_chart, onTab: (){
                Navigator.pushNamed(context, Assignments.id);
              },),

              myCards(title: 'Post Assignment', icon: Icons.question_mark, onTab: (){
                Navigator.pushNamed(context, Post_Assignment.id);
              },),

              Container(
                height: 280,
                width: double.infinity,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ADVERTISEMENTS',style: kTextStlye,),
                      Image.asset('images/adams.png',scale: 4,)
                    ],
                  ),
                  elevation: 8,
                  shadowColor: Colors.green,
                  margin: EdgeInsets.all(20),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      ,

    );
  }
  //A log Out Method
Future<void>logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.id);
}
}
