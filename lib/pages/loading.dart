import 'package:app/pages/login.dart';
import 'package:app/pages/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (_, snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final authenticado = await authService.isLoggedIn();

    if (authenticado) {
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (
            _,
            __,
            ___,
          ) =>
              UsuariosPage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (
            _,
            __,
            ___,
          ) =>
              LoginPage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    }
  }
}
