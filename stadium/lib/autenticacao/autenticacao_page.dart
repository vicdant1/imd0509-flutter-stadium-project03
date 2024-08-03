import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/home/pages/home_page.dart';

class AutenticacaoPage extends StatefulWidget {
  const AutenticacaoPage({super.key});

  @override
  State<AutenticacaoPage> createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {
  final loginTextController = TextEditingController();
  final senhaTextController = TextEditingController();
  late bool isActive;
  late bool isobscureText;

  @override
  void initState() {
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
                buildCampos(),
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
                esqueceuSenha(),
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

  Widget buildCampos() {
    return Column(
      children: [
        TextFormField(
          controller: loginTextController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: 'Email',
            filled: true,
            hintStyle: const TextStyle(
              color: Color(0xffBDBDBD),
              fontSize: 16,
            ),
            isDense: true,
            fillColor: const Color(0xffF6F6F6),
            focusColor: const Color(0xffF6F6F6),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(0xffC8C8C8).withOpacity(0.5),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(0xffC8C8C8).withOpacity(0.5),
                width: 1.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          child: TextFormField(
            obscureText: isobscureText,
            controller: senhaTextController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              hintText: 'Senha',
              hintStyle: const TextStyle(
                color: Color(0xffBDBDBD),
                fontSize: 16,
              ),
              isDense: true,
              filled: true,
              suffix: GestureDetector(
                onTap: () {
                  isobscureText = !isobscureText;
                  setState(() {});
                },
                child: const Text(
                  'Mostrar',
                  style: TextStyle(
                      color: Color(
                        0xff09554B,
                      ),
                      fontWeight: FontWeight.bold),
                ),
              ),
              fillColor: const Color(0xffF6F6F6),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xffC8C8C8).withOpacity(0.5),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xffC8C8C8).withOpacity(0.5),
                  width: 1.0,
                ),
              ),
            ),
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
              text: 'Concordo com os ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  height: 1.4,
                  fontFamily: 'Poppins'),
              children: [
                TextSpan(
                    text: 'Termos de políticas e privacidade',
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
      onTap: () => Modular.to
          .push(MaterialPageRoute(builder: (context) => const HomePage())),
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

  Widget esqueceuSenha() {
    return const Text('Esqueceu a senha?',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(
              0xff09554B,
            ),
            fontSize: 15));
  }
}
