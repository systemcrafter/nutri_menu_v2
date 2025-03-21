import 'package:flutter/material.dart';
import 'package:nutri_menu_v2/pages/recipe_page.dart';
import 'package:nutri_menu_v2/pages/account_page.dart';
import 'package:nutri_menu_v2/pages/settings_page.dart';
import 'package:nutri_menu_v2/pages/logout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    _RecipesList(),
    const AccountPage(),
    const SettingsPage(),
    const LogoutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 20,
            ),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20,
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
              size: 20,
            ),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'QuickSand'),
        unselectedFontSize: 10,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.orange,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                _showBottom(context);
              })
          : null,
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              color: Colors.white,
              child: const FormRecipes(),
            ));
  }
}

class _RecipesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _Recipes(context),
          _Recipes(context),
          _Recipes(context),
          _Recipes(context),
        ],
      ),
    );
  }
}

Widget _Recipes(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipePage(
                    recipeName: 'Pizza',
                  )));
    },
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      Image.asset('assets/images/pizza.png', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 26),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Pizza',
                      style: TextStyle(fontSize: 16, fontFamily: 'QuickSand')),
                  const SizedBox(height: 4),
                  Container(
                    height: 2,
                    width: 75,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 4),
                  const Text('Vero A',
                      style: TextStyle(fontSize: 14, fontFamily: 'QuickSand')),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

class FormRecipes extends StatelessWidget {
  const FormRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeImage = TextEditingController();
    final TextEditingController _recipeDescription = TextEditingController();

    return Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Agregar Receta',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QuickSand')),
              const SizedBox(height: 10),
              _buildtextField(
                  controller: _recipeName,
                  label: 'Nombre de la Receta',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un nombre';
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              _buildtextField(
                  controller: _recipeAuthor,
                  label: 'Autor de la Receta',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un nombre de autor';
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              _buildtextField(
                  controller: _recipeImage,
                  label: 'Enlace Imagen de la Receta',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un enlace de imagen';
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              _buildtextField(
                  maxLines: 4,
                  controller: _recipeDescription,
                  label: 'Receta',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese la receta';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ))
            ],
          ),
        ));
  }

  Widget _buildtextField(
      {required String label,
      required TextEditingController controller,
      required String? Function(String?) validator,
      int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle:
              const TextStyle(color: Colors.orange, fontFamily: 'QuickSand'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(10))),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
