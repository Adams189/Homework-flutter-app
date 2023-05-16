

import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? uid;
  String? firstName;
  String? lastName;
  String? email;

  UserModel({this.uid, this.email, this.firstName, this.lastName});

  //receiving data from server we create a map
factory UserModel.fromMap(map){
  return UserModel(
    uid: map['uid'],
    email: map['email'],
    firstName: map['firstName'],
    lastName: map['lastName']

  );
}
//sending data to our server
Map <String, dynamic > toMap(){
  return{
    'uid': uid,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,

  };

}
}