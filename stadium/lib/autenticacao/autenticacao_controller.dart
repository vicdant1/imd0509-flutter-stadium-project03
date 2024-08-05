import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stadium/autenticacao/autenticacao_repository.dart';
import 'package:stadium/models/user.dart';
import 'package:stadium/services/shared_prefs.dart';
import 'package:stadium/utils/custom_snackbar.dart';

part 'autenticacao_controller.g.dart';

class AutenticacaoController = _AutenticacaoControllerBase
    with _$AutenticacaoController;

abstract class _AutenticacaoControllerBase with Store {
  final repository = AutenticacaoRepository();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  final sharedPrefs = SharedPrefsService();

  @observable
  Users? usuarioLogado;

  @observable
  File? fotoPerfil;

  @observable
  File? fotoPerfilCadastro;

  @action
  Future login(String email, String senha, BuildContext context) async {
    try {
      List<Users> users = await repository.getUsers();
      usuarioLogado = users
          .where((element) =>
              element.email == email &&
              element.senha == md5.convert(utf8.encode(senha)).toString())
          .toList()
          .first;
      if (usuarioLogado != null) {
        await converteBase64ParaFile(usuarioLogado?.base64Perfil ?? '');
      }
      sharedPrefs.save(usuarioLogado?.toJson());
      Modular.to.pushNamed('/home');
    } catch (e) {
      // ignore: use_build_context_synchronously
      customSnackBar(
        'Senha ou email incorretos',
        context: context,
        corFundo: Colors.red,
      );
    }
  }

  @action
  Future converteBase64ParaFile(String? base64) async {
    Directory fileDir = await getApplicationDocumentsDirectory();
    final decodedBytes = base64Decode(base64!.trim());

    fotoPerfil = File('${fileDir.path}/fotoperfil.png');
    fotoPerfil?.writeAsBytesSync(decodedBytes);
  }

  Future cadastrarUsuario(Users users) async {
    try {
      await repository.postUser(users);
    } catch (e) {
      // Handle error
    }
  }

  @action
  Future verificaPersistencia() async {
    bool? dadosPersistido = await sharedPrefs.contem();
    if (dadosPersistido) {
      bool autenticado = await _authenticate();
      if (autenticado) {
        usuarioLogado = Users.fromJson(await sharedPrefs.read());
        await converteBase64ParaFile(usuarioLogado?.base64Perfil ?? '');
        Modular.to.pushNamed('/home');
      }
    }
  }

  Future<bool> _authenticate() async {
    try {
      final List<BiometricType> availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        bool authenticated = await _localAuthentication.authenticate(
            localizedReason: 'Authenticate to access the app',
            options: const AuthenticationOptions(
                useErrorDialogs: true, stickyAuth: true, biometricOnly: true));

        return authenticated;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
