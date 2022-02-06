import 'package:app/global/environment.dart';
import 'package:app/models/mensajes_response.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/mensajes/$usuarioId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': await AuthService.getToken() ?? '',
      },
    );

    final mensajesResponse = mensajesResponseFromJson(resp.body);

    return mensajesResponse.mensajes;
  }
}
