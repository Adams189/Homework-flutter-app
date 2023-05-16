
import 'package:flutter/material.dart';

import '../constants.dart';

class myCards extends StatelessWidget {
  myCards({required this.title, required this.icon , this.onTab});

  final String title;
  final onTab;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTab,
      child: Container(
        height: 150,
        width: 200,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.green,size: 35),
              Text(title,style: kTextStlye,)
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
    );
  }
}