import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const String id = 'CategoriesRoute';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Categories Page'),),
    );
  }
}
