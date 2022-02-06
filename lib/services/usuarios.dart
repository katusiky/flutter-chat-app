import 'package:app/global/environment.dart';
import 'package:app/models/usuario.dart';
import 'package:app/models/usuarios_response.dart';
import 'package:app/services/auth.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/usuarios'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': await AuthService.getToken() ?? '',
        },
      );

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
