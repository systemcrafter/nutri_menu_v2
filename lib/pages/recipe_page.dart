import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  final String recipeName;
  const RecipePage({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(recipeName),
      titleTextStyle:
          TextStyle(color: Colors.white, fontFamily: 'Quicksand', fontSize: 20),
      backgroundColor: Colors.orange,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ));
  }
}
