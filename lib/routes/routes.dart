import 'package:flutter/material.dart';

import '../pages/chat.dart';
import '../pages/loading.dart';
import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/usuarios.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
