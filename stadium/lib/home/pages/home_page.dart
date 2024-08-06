import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/autenticacao/autenticacao_controller.dart';
import 'package:stadium/home/home_controller.dart';
import 'package:stadium/home/pages/clubes_page.dart';
import 'package:stadium/home/pages/estadio_page.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/models/estadios.dart';
import 'package:stadium/utils/status.dart';
import 'package:stadium/utils/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Modular.get();
  final authController = Modular.get<AutenticacaoController>();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.createNew,
        backgroundColor: const Color(0xff09554B),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildHeader(),
          const SizedBox(
            height: 20,
          ),
          _buildLocal(),
          const SizedBox(
            height: 5,
          ),
          _buildSection(),
          const SizedBox(
            height: 15,
          ),
          oberserListClubesEstadios()
        ]),
      ),
    );
  }

  Widget oberserListClubesEstadios() {
    return Observer(builder: (_) {
      if (controller.valorSelecionado == 1) {
        return Column(
          children: controller.clubes.map((c) {
            return _buildCardClub(c);
          }).toList(),
        );
      } else {
        return Column(children: [
          buildBotaoEstadiosProximos(),
          ...controller.estadios.map((e) {
            switch (controller.estadiosProximos) {
              case true:
                if (e.localizacao ==
                    controller.localizacao?.split(',')[3].trim()) {
                  return _buildCardStadium(e);
                } else {
                  return const SizedBox();
                }

              case false:
                return _buildCardStadium(e);
            }
          }).toList(),
        ]);
      }
    });
  }

  Widget _buildLocal() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_rounded,
            color: Color(0xff09554B),
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sua Localização',
                style: titleStyle,
              ),
              const SizedBox(
                height: 3,
              ),
              Observer(builder: (_) {
                switch (controller.statusLocalizacao) {
                  case Status.loading:
                    return SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: const LinearProgressIndicator(
                            backgroundColor: Color(0xff09554B),
                            color: Colors.white));
                  default:
                    return SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(controller.localizacao ?? '',
                            style: const TextStyle(
                              color: Color(0xff09554B),
                              fontSize: 13,
                            )));
                }
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection() {
    return Center(
      child: Observer(builder: (_) {
        return CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.all(5),
            children: {
              0: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                  child: Text(
                    'Estadios',
                    style: titleStyle,
                  )),
              1: Padding(
                padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Text(
                  'Clubes',
                  style: titleStyle,
                ),
              ),
            },
            groupValue: controller.valorSelecionado,
            onValueChanged: controller.setValorSelecionado);
      }),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 70, 30, 20),
      height: 150,
      decoration: const BoxDecoration(
        color: Color(
          0xff09554B,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Observer(builder: (_) {
              return SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: FileImage(
                    authController.fotoPerfil!,
                  ),
                ),
              );
            }),
            const SizedBox(
              width: 15,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem-vindo ao Stadium!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'O melhor app de futebol',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ]),
          GestureDetector(
            onTap: () {
              controller.logout();
            },
            child: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardClub(Clubes clubes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Modular.to.push(MaterialPageRoute(
            builder: (context) => ClubePage(clube: clubes),
          ));
        },
        child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                    child: Image.network(clubes.imagem)),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      clubes.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff09554B),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person,
                            size: 20, color: Color(0xff09554B)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${clubes.jogadores?.length.toString() ?? 0} Jogadores',
                          style: const TextStyle(
                            color: Color(0xff09554B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.sports_soccer,
                            size: 20, color: Color(0xff09554B)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${clubes.quantidadeTitulos.toString()} Títulos',
                          style: const TextStyle(
                            color: Color(0xff09554B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildCardStadium(Estadios estadio) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Modular.to.push(MaterialPageRoute(
              builder: (context) => EstadioPage(estadio: estadio)));
        },
        child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      estadio.imagem,
                    )),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      estadio.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff09554B),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.sports_soccer,
                            size: 20, color: Color(0xff09554B)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          estadio.clubNome,
                          style: const TextStyle(
                            color: Color(0xff09554B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 20, color: Color(0xff09554B)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          estadio.localizacao,
                          style: const TextStyle(
                            color: Color(0xff09554B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget buildBotaoEstadiosProximos() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Row(
        children: [
          Observer(builder: (_) {
            return CupertinoSwitch(
                activeColor: const Color(0xff09554B),
                value: controller.estadiosProximos,
                onChanged: controller.setEstadioProximos);
          }),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Ver apenas estadios próximos',
            style: TextStyle(
              color: Color(0xff09554B),
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
