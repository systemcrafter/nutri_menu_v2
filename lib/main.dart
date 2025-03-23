import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutri_menu_v2/providers/user_provider.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Puedes agregar más providers aquí si es necesario
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutri Menu App',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
