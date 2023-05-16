import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({required this.title, required this.onPressed});
  final String title;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.green[400],
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: onPressed,
          child: Text(title, style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),
    );
  }
}