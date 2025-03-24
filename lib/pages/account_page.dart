//account_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutri_menu_v2/providers/user_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cuenta')),
      body: Center(
        child: userProvider.userName == null
            ? const CircularProgressIndicator()
            : Text(
                'Bienvenid@ ${userProvider.userName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange,
                    fontFamily: 'quicksand',
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
