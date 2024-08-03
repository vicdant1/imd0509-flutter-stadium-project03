import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/autenticacao/autenticacao_controller.dart';
import 'package:stadium/autenticacao/widgets/campos_auth_widget.dart';
import 'package:stadium/models/user.dart';
import 'package:stadium/services/files_service.dart';
import 'package:stadium/services/select_file_service_widget.dart';
import 'package:stadium/utils/custom_snackbar.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final controller = Modular.get<AutenticacaoController>();
  final loginTextController = TextEditingController();
  final senhaTextController = TextEditingController();

  @override
  void initState() {
    loginTextController.clear();
    senhaTextController.clear();
    controller.fotoPerfilCadastro = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 180, 20, 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildHead(),
                const SizedBox(
                  height: 50,
                ),
                CamposAuthWidget(
                  loginTextController: loginTextController,
                  senhaTextController: senhaTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                anexoFoto(),
                const SizedBox(
                  height: 20,
                ),
                botaoAcessar(),
                const SizedBox(
                  height: 25,
                ),
                registerAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHead() {
    return const Column(
      children: [
        Text(
          'Cadastro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        )
      ],
    );
  }

  Widget botaoAcessar() {
    return GestureDetector(
      onTap: () async {
        await controller.cadastrarUsuario(
          Users(
            loginTextController.text,
            md5.convert(utf8.encode(senhaTextController.text)).toString(),
            await convertFiletoBase64(
                controller.fotoPerfilCadastro?.path ?? ''),
          ),
        );

        // ignore: use_build_context_synchronously
        customSnackBar('Usuário cadastrado com sucesso',
            context: context, corFundo: Colors.green, icon: Icons.check);
        Modular.to.pop();
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(
            0xff09554B,
          ),
        ),
        child: const Center(
            child: Text(
          'Cadastrar',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        )),
      ),
    );
  }

  Widget registerAccount() {
    return GestureDetector(
      onTap: () {
        Modular.to.pop();
      },
      child: const Text('Cancelar',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(
                0xff09554B,
              ),
              fontSize: 15)),
    );
  }

  Widget anexoFoto() {
    return Observer(builder: (_) {
      return Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            popupSelecaoAnexo();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xff09554B),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(controller.fotoPerfilCadastro != null
                    ? Icons.check
                    : Icons.upload_rounded),
                const SizedBox(
                  width: 10,
                ),
                Text(controller.fotoPerfilCadastro != null
                    ? 'Foto cadastrada com sucesso'
                    : 'Anexar Foto de perfil'),
              ],
            ),
          ),
        ),
      );
    });
  }

  void popupSelecaoAnexo() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        side: BorderSide(style: BorderStyle.none),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const SelectFileService();
      },
    );
  }
}
