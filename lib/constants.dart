import 'package:flutter/material.dart';

const kEmailTextFeildDecoration =  InputDecoration(
hintText: 'Email',
prefixIcon: Icon(Icons.mail,),
contentPadding:
EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
border: OutlineInputBorder(
borderRadius: BorderRadius.all(Radius.circular(32.0)),
),
enabledBorder: OutlineInputBorder(
borderSide:
BorderSide(color: Colors.green, width: 1.0),
borderRadius: BorderRadius.all(Radius.circular(32.0)),
),
focusedBorder: OutlineInputBorder(
borderSide:
BorderSide(color: Colors.green, width: 2.0),
borderRadius: BorderRadius.all(Radius.circular(32.0)),
),
);

const kTextStlye = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Color(0xFF707070)
);