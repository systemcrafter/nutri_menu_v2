import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para SystemNavigator.pop()
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
    ).then((value) {
      // Este bloque se ejecuta cuando el diálogo se cierra
      if (!context.mounted) {
        return; // Verifica si el contexto todavía está montado
      }

      if (value == 'Sí') {
        // Acción si el usuario elige "Sí"
        _salirDeLaApp();
      } else {
        // Acción si el usuario elige "No"
        _irAHomePage(context);
      }
    });
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
}
