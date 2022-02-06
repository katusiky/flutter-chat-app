import 'dart:convert';

import 'package:app/global/environment.dart';
import 'package:app/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();

    _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);

      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);
      autenticando = false;

      return true;
    }

    autenticando = false;
    return false;
  }

  Future<dynamic> register(String name, String email, String password) async {
    autenticando = true;

    final data = {
      'nombre': name,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);
      autenticando = false;

      return true;
    }

    autenticando = false;

    final respBody = jsonDecode(resp.body);
    return respBody['message'];
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    }

    _logout();
    return false;
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logout() async {
    await _storage.delete(key: 'token');
  }
}
