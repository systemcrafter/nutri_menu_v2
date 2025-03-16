// main.dart
import 'package:flutter/material.dart';
import 'package:nutri_menu_v2/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RecipeBook());
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              'Libro de Recetas',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            bottom: TabBar(tabs: [Tab(icon: Icon(Icons.home), text: 'Inicio')]),
          ),
          body: TabBarView(children: [HomePage()])),
    );
  }
}
