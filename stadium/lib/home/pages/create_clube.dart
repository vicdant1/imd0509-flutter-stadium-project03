import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/home/home_controller.dart';
import 'package:stadium/home/widgets/custom_form.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/utils/custom_snackbar.dart';

class CreateClube extends StatefulWidget {
  const CreateClube({super.key});

  @override
  State<CreateClube> createState() => _CreateClubeState();
}

class _CreateClubeState extends State<CreateClube> {
  @override
  void initState() {
    controller.nomeController.clear();
    super.initState();
  }

  final HomeController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Criar Novo Clube'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomForms(controller: controller.nomeController, hint: 'Nome'),
              const SizedBox(
                height: 15,
              ),
              CustomForms(
                  controller: controller.imagemUrlController,
                  hint: 'Imagem URL'),
              const SizedBox(
                height: 15,
              ),
              CustomForms(
                  controller: controller.tituloController, hint: 'TItulos'),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff09554B),
              ),
              onPressed: () async {
                await controller.postClube(
                  Clubes(
                      nome: controller.nomeController.text,
                      imagem: controller.imagemUrlController.text,
                      quantidadeTitulos:
                          int.parse(controller.tituloController.text),
                      jogadores: []),
                );
                // ignore: use_build_context_synchronously
                customSnackBar('Clube criado com sucesso',
                    context: context,
                    corFundo: const Color.fromARGB(255, 82, 151, 86),
                    icon: Icons.done);
                controller.getClubes();
                Modular.to.pop();
              },
              child: const Text('Salvar'),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Cancelar')
      ]),
    );
  }
}
