// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/home/home_controller.dart';
import 'package:stadium/home/widgets/custom_campo.dart';
import 'package:stadium/home/widgets/custom_form.dart';
import 'package:stadium/models/estadios.dart';
import 'package:stadium/utils/custom_snackbar.dart';

class CreateEstadio extends StatefulWidget {
  final bool? isEdit;
  final String? nome;
  const CreateEstadio({
    Key? key,
    this.isEdit,
    this.nome,
  }) : super(key: key);

  @override
  State<CreateEstadio> createState() => _CreateEstadioState();
}

class _CreateEstadioState extends State<CreateEstadio> {
  final HomeController controller = Modular.get();

  @override
  void initState() {
    controller.getClubes();
    if (widget.isEdit == false) {
      controller.nomeController.clear();
      controller.descricaoController.clear();
      controller.capacidadeMax.clear();
      controller.imagemUrlController.clear();
      controller.cidadeController.clear();
      controller.enderecoController.clear();
      controller.latitudeController.clear();
      controller.longitudeController.clear();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Criar Novo Estádio'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomForms(
                    controller: controller.nomeController, hint: 'Nome'),
                const SizedBox(
                  height: 15,
                ),
                CustomForms(
                  controller: controller.descricaoController,
                  hint: 'Descrição',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomForms(
                    controller: controller.capacidadeMax,
                    hint: 'Capacidade ( Ex: "180 mil" )'),
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
                    controller: controller.cidadeController, hint: 'Cidade'),
                const SizedBox(
                  height: 15,
                ),
                CustomForms(
                    controller: controller.enderecoController,
                    hint: 'Endereço'),
                const SizedBox(
                  height: 15,
                ),
                CustomForms(
                    controller: controller.latitudeController,
                    hint: 'Latitude'),
                const SizedBox(
                  height: 15,
                ),
                CustomForms(
                    controller: controller.longitudeController,
                    hint: 'Longitude'),
                const SizedBox(
                  height: 25,
                ),
                _buildClubes(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
                  if (widget.isEdit == true) {
                    await controller.patchEstadios(
                        Estadios(
                          nome: controller.nomeController.text,
                          capacidade: controller.capacidadeMax.text,
                          imagem: controller.imagemUrlController.text,
                          descricao: controller.descricaoController.text,
                          localizacao: controller.cidadeController.text,
                          endereco: controller.enderecoController.text,
                          lat: double.parse(controller.latitudeController.text),
                          long:
                              double.parse(controller.longitudeController.text),
                          clubId: controller.idSelecionado,
                          clubNome: controller.clubes
                              .where((element) =>
                                  element.id == controller.idSelecionado)
                              .first
                              .nome,
                        ),
                        widget.nome ?? '');
                    Modular.to.pop();
                  } else {
                    await controller.postEstadio(
                      Estadios(
                        nome: controller.nomeController.text,
                        capacidade: controller.capacidadeMax.text,
                        imagem: controller.imagemUrlController.text,
                        descricao: controller.descricaoController.text,
                        localizacao: controller.cidadeController.text,
                        endereco: controller.enderecoController.text,
                        lat: double.parse(controller.latitudeController.text),
                        long: double.parse(controller.longitudeController.text),
                        clubId: controller.idSelecionado,
                        clubNome: controller.clubes
                            .where((element) =>
                                element.id == controller.idSelecionado)
                            .first
                            .nome,
                      ),
                    );
                  }

                  controller.getEstadios();
                  customSnackBar(
                      widget.isEdit == true
                          ? 'Estadio editado com sucesso'
                          : 'Estádio criado com sucesso',
                      context: context,
                      corFundo: const Color.fromARGB(255, 82, 151, 86),
                      icon: Icons.done);
                  Modular.to.pop();
                },
                child: Text(widget.isEdit == true ? 'Editar' : 'Salvar'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Cancelar')
        ]),
      ),
    );
  }

  Widget _buildClubes() {
    return Observer(builder: (_) {
      return CampoGeralWidget(
        texto: 'Clube do estádio',
        valorSelecionado: controller.valorDropDown,
        onChanged: (String? value) {
          setState(() {
            controller.valorDropDown = value!;
          });
        },
        items: controller.clubes
            .map((e) => e.nome)
            .toList()
            .toSet()
            .toList()
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  onTap: () async {
                    controller.idSelecionado = controller.clubes
                        .where((element) => element.nome == e)
                        .first
                        .id;
                  },
                  child: Text(e),
                ))
            .toList(),
      );
    });
  }
}
