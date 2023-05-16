import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/user_model.dart';
import '../login_screen.dart';




class ProfileScreen extends StatefulWidget {
  static const String id = 'profileRoute';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
  @override
  void initState(){
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white70,
        title: Center(child: Text('My Profile',style:kTextStlye,)),),
      body: SingleChildScrollView(child: Container(
        child: Column(
        children: [  Container(
          height: 170,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 100,
                          width: 100,
                          child: Image.asset('images/Profile.jpg',scale: 5,)),
                    ),
                    SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Text(' ${loggedInUser.firstName} ${loggedInUser.lastName} ',style:
                        kTextStlye,),
                        SizedBox(height: 20,),
                        Text(' ${loggedInUser.email} ',style:
                        kTextStlye,),
                      ],
                    ),

                  ],
                ),
                elevation: 8,
                shadowColor: Colors.green,
                margin: EdgeInsets.all(20),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
              ),

            ],
          ),
        ),
          ProfileTiles(title: 'My Posts',onTab: (){},),
          SizedBox(height: 10,),
          ProfileTiles(title: 'Wallet',onTab: (){},),
          SizedBox(height: 10,),
          SizedBox(height: 10,),
          ProfileTiles(title: 'History',onTab: (){},),
          SizedBox(height: 10,),
          ProfileTiles(title: 'My Posts',onTab: (){},),
          SizedBox(height: 10,),
          ProfileTiles(title: 'Settings',onTab: (){},),
          ActionChip(label: Text('LogOut'),
            backgroundColor: Colors.red,
            onPressed: (){
              removePreference();
              logOut(context);
            },
          ),
        ],
      ),
      ),
      )
    );
  }
  Future<void>logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.id);
  }
  void removePreference () async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("user_id");
  }
}

class ProfileTiles extends StatelessWidget {

  ProfileTiles({required this.title, this.onTab});

   final String title;
   final  onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Card(
        child: ListTile(
          title: Text(title,style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
          ),),
          trailing: Icon(Icons.navigate_next_rounded),
        ),
      ),
    );
  }
}
