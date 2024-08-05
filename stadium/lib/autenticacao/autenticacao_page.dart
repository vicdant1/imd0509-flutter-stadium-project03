import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/autenticacao/autenticacao_controller.dart';
import 'package:stadium/autenticacao/widgets/campos_auth_widget.dart';

class AutenticacaoPage extends StatefulWidget {
  const AutenticacaoPage({super.key});

  @override
  State<AutenticacaoPage> createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {
  final controller = Modular.get<AutenticacaoController>();

  final loginTextController = TextEditingController();
  final senhaTextController = TextEditingController();

  late bool isActive;
  late bool isobscureText;

  @override
  void initState() {
    controller.verificaPersistencia();
    isActive = false;
    isobscureText = true;
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
                  isobscureText: isobscureText,
                ),
                const SizedBox(
                  height: 20,
                ),
                checkTheBox(),
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
          'Acessar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        )
      ],
    );
  }

  Widget checkTheBox() {
    return Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            value: isActive,
            activeColor: const Color(
              0xff09554B,
            ),
            onChanged: (value) {
              isActive = !isActive;

              setState(() {});
            }),
        Flexible(
          child: RichText(
            text: const TextSpan(
              text: 'Salvar minhas ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  height: 1.4,
                  fontFamily: 'Poppins'),
              children: [
                TextSpan(
                    text: 'informações de login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xff09554B,
                      ),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget botaoAcessar() {
    return GestureDetector(
      onTap: () async {
        await controller.login(
            loginTextController.text, senhaTextController.text, context);
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(
            0xff09554B,
          ),
        ),
        child: const Center(
            child: Text(
          'Acessar',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        )),
      ),
    );
  }

  Widget registerAccount() {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/cadastro');
      },
      child: const Text('Cadastra-se agora',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(
                0xff09554B,
              ),
              fontSize: 15)),
    );
  }
}
