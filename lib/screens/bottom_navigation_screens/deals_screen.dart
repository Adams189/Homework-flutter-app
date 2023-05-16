import 'package:flutter/material.dart';

class DealScreen extends StatefulWidget {

  static const String id = 'dealRoute';
  @override
  State<DealScreen> createState() => _DealScreenState();
}

class _DealScreenState extends State<DealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Deals Page'),),
    );
  }
}
