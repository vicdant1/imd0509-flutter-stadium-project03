import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/home/home_controller.dart';
import 'package:stadium/home/pages/clubes_page.dart';
import 'package:stadium/home/pages/create_clube.dart';
import 'package:stadium/home/pages/create_estadio_page.dart';
import 'package:stadium/home/pages/estadio_page.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/models/estadios.dart';
import 'package:stadium/utils/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Modular.get();

  @override
  void initState() {
    controller.getEstadios();
    controller.getClubes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.valorSelecionado == 1) {
            Modular.to.push(
                MaterialPageRoute(builder: (context) => const CreateClube()));
          } else {
            Modular.to.push(
                MaterialPageRoute(builder: (context) => const CreateEstadio()));
          }
        },
        backgroundColor: const Color(0xff09554B),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildHeader(),
          const SizedBox(
            height: 25,
          ),
          _buildSection(),
          const SizedBox(
            height: 15,
          ),
          Observer(builder: (_) {
            if (controller.valorSelecionado == 1) {
              return Column(
                children: controller.clubes.map((c) {
                  return _buildCardClub(c);
                }).toList(),
              );
            } else {
              return Column(
                children: controller.estadios.map((e) {
                  return _buildCardStadium(e);
                }).toList(),
              );
            }
          }),
        ]),
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
      padding: const EdgeInsets.fromLTRB(5, 70, 0, 0),
      height: 140,
      decoration: const BoxDecoration(
        color: Color(
          0xff09554B,
        ),
      ),
      child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
}
