import 'package:flutter/material.dart';
import 'package:nutri_menu_v2/pages/recipe_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _Recipes(context),
          _Recipes(context),
          _Recipes(context),
          _Recipes(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showBottom(context);
          }),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              color: Colors.white,
              child: FormRecipes(),
            ));
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
                    child: Image.asset('assets/images/pizza.png',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Pizza',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'QuickSand')),
                    SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 75,
                      color: Colors.orange,
                    ),
                    SizedBox(height: 4),
                    Text('Vero A',
                        style:
                            TextStyle(fontSize: 14, fontFamily: 'QuickSand')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Agregar Receta',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QuickSand')),
              SizedBox(height: 10),
              _buildtextField(
                  controller: _recipeName,
                  label: 'Nombre de la Receta',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un nombre';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
              _buildtextField(
                  controller: _recipeAuthor,
                  label: 'Autor de la Receta',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un nombre de autor';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
              _buildtextField(
                  controller: _recipeImage,
                  label: 'Enlace Imagen de la Receta',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un enlace de imagen';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
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
              SizedBox(height: 16),
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
                child: Text(
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
          labelStyle: TextStyle(color: Colors.orange, fontFamily: 'QuickSand'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(10))),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
