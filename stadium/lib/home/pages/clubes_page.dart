import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/home/home_controller.dart';
import 'package:stadium/home/widgets/custom_form.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/models/jogadores.dart';
import 'package:stadium/utils/custom_snackbar.dart';

class ClubePage extends StatefulWidget {
  final Clubes clube;

  const ClubePage({super.key, required this.clube});

  @override
  State<ClubePage> createState() => _ClubePageState();
}

class _ClubePageState extends State<ClubePage> {
  final HomeController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.clube.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buidlHeader(),
            const SizedBox(
              height: 20,
            ),
            _buildJogadores()
          ],
        ),
      ),
    );
  }

  Widget _buidlHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 65,
          height: 65,
          child: Image.network(
            widget.clube.imagem,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.clube.nome,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'Clube de Futebol',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJogadores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Jogadores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.nomeController.clear();
                controller.posicaoController.clear();
                addJogador();
              },
              child: const Icon(
                Icons.add,
                size: 33,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Observer(builder: (_) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: widget.clube.jogadores?.length ?? 0,
            itemBuilder: (context, index) {
              final jogador = widget.clube.jogadores?[index];
              return ListTile(
                title: GestureDetector(
                  onTap: () {
                    controller.nomeController.text = jogador?.nome ?? '';
                    controller.posicaoController.text = jogador?.posicao ?? '';
                    editJogador(index);
                  },
                  child: Row(
                    children: [
                      Text(jogador?.nome ?? ''),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.edit)
                    ],
                  ),
                ),
                subtitle: Text(jogador?.posicao ?? ''),
                leading: const Icon(
                  Icons.person,
                  size: 40,
                ),
                trailing: GestureDetector(
                    onTap: () async {
                      widget.clube.jogadores?.removeAt(index);

                      await controller.postJogador(
                          widget.clube.jogadores ?? [], widget.clube.id);

                      await controller.getClubes();
                      setState(() {});
                    },
                    child: const Icon(Icons.delete)),
              );
            },
          );
        }),
      ],
    );
  }

  Future editJogador(int index) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                const Text(
                  'Editar Jogador',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForms(
                  controller: controller.nomeController,
                  hint: 'Nome',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomForms(
                  controller: controller.posicaoController,
                  hint: 'Posição',
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff09554B),
                    ),
                    onPressed: () async {
                      widget.clube.jogadores?.removeAt(index);

                      controller.jogadores =
                          widget.clube.jogadores as List<Jogador>;
                      controller.jogadores.add(
                        Jogador(
                          nome: controller.nomeController.text,
                          posicao: controller.posicaoController.text,
                        ),
                      );
                      await controller.postJogador(
                        controller.jogadores,
                        widget.clube.id,
                      );
                      // ignore: use_build_context_synchronously
                      customSnackBar('Jogador editado com sucesso',
                          context: context,
                          corFundo: const Color.fromARGB(255, 82, 151, 86),
                          icon: Icons.done);
                      await controller.getClubes();
                      Modular.to.pop();
                      setState(() {});
                    },
                    child: const Text('Editar Jogador'),
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }

  Future addJogador() {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                const Text(
                  'Adicionar Jogador',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForms(
                  controller: controller.nomeController,
                  hint: 'Nome',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomForms(
                  controller: controller.posicaoController,
                  hint: 'Posição',
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff09554B),
                    ),
                    onPressed: () async {
                      controller.jogadores =
                          widget.clube.jogadores as List<Jogador>;
                      controller.jogadores.add(
                        Jogador(
                          nome: controller.nomeController.text,
                          posicao: controller.posicaoController.text,
                        ),
                      );
                      await controller.postJogador(
                        controller.jogadores,
                        widget.clube.id,
                      );
                      // ignore: use_build_context_synchronously
                      customSnackBar('Jogador adicionado com sucesso',
                          context: context,
                          corFundo: const Color.fromARGB(255, 82, 151, 86),
                          icon: Icons.done);
                      await controller.getClubes();
                      Modular.to.pop();
                      setState(() {});
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}
