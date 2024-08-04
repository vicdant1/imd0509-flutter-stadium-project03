import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  // Instância global para toda aplicação (Singleton pattern)
  static final SharedPrefsService _instance =
      SharedPrefsService._privateConstructor();

  // Construtor privado. Chamado somente quando a classe é instanciada pela primeira vez.
  // Atualmente não faz nada.
  SharedPrefsService._privateConstructor();

  // Construtor público. Retorna a mesma instância toda vez que é chamado.
  factory SharedPrefsService() {
    return _instance;
  }

  Future read() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString('loginResponse') ?? '');
  }

  Future<bool> remove() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove('loginResponse');
  }

  Future<bool> save(value) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString('loginResponse', json.encode(value));
  }

  Future<bool> contem() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('loginResponse');
  }
}
