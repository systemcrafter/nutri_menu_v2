import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para SystemNavigator.pop()
import 'package:http/http.dart' as http; // Para hacer solicitudes HTTP
import 'package:shared_preferences/shared_preferences.dart'; // Para recuperar el token
import 'dart:convert'; // Para manejar JSON
import 'home_page.dart'; // Importa la clase HomePage

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mostrar el diálogo automáticamente cuando la página se carga
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mostrarDialogo(context);
    });

    return Scaffold();
  }

  void _mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Desea salir de la aplicación?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context, 'No'); // Cierra el diálogo y devuelve 'No'
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context, 'Sí'); // Cierra el diálogo y devuelve 'Sí'
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    ).then((value) async {
      // Este bloque se ejecuta cuando el diálogo se cierra
      if (!context.mounted) {
        return; // Verifica si el contexto todavía está montado
      }

      if (value == 'Sí') {
        // Acción si el usuario elige "Sí"
        await _logout(context); // Llama a la función de logout
        _salirDeLaApp();
      } else {
        // Acción si el usuario elige "No"
        _irAHomePage(context);
      }
    });
  }

  // Función para hacer logout
  Future<void> _logout(BuildContext context) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/logout');
    final token = await getToken(); // Recupera el token guardado

    if (token == null) {
      print('No se encontró el token de autenticación');
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Envía el token en el header
          'Accept': 'application/json',
        },
      );

      // Imprime la respuesta en la consola de depuración
      print('Respuesta del servidor (logout):');
      print('Código de estado: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        // Logout exitoso
        print('Logout exitoso');
      } else {
        // Manejo de errores
        print('Error en el logout: ${response.body}');
      }
    } catch (e) {
      // Manejo de excepciones
      print('Excepción en el logout: $e');
    }
  }

  void _salirDeLaApp() {
    // Cierra la aplicación (funciona en Android)
    SystemNavigator.pop();
  }

  void _irAHomePage(BuildContext context) {
    // Navega a la página de inicio reemplazando la actual
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // Función para recuperar el token guardado
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
