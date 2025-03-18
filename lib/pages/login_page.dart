import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutri_menu_v2/pages/register_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  // Función asíncrona para manejar el login
  Future<bool> login(String email, String password) async {
    const String baseUrl = 'http://10.0.2.2:8000/api/users'; // URL para Android

    var client = http.Client();
    var url = Uri.parse(baseUrl);
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'cache-control': 'no-cache'
    };

    var response = await client.get(url, headers: headers);

    debugPrint(response.body);

    // Verifica si la respuesta es exitosa (código 200)
    if (response.statusCode == 200) {
      return true; // Autenticación exitosa
    } else {
      return false; // Autenticación fallida
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Inicio de Sesión',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: userController,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: passwordController,
                  obscureText: true, // Oculta la contraseña
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String email = userController.text;
                  String password = passwordController.text;

                  // Cierra el teclado activo
                  FocusScope.of(context).unfocus();

                  // Verifica si los campos están vacíos
                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Los campos de usuario y contraseña no pueden estar vacíos.',
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else {
                    // Llama a la función login y espera su resultado
                    bool isAuthenticated = await login(email, password);

                    // Verifica si el widget todavía está montado
                    if (!context.mounted) return;

                    if (isAuthenticated) {
                      // Navega a HomePage si las credenciales son correctas
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } else {
                      // Muestra un mensaje de error si las credenciales no son válidas
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario o contraseña incorrectos'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes una cuenta aún?   '),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text('Regístrate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
