// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:latlong2/latlong.dart';
import 'package:stadium/home/home_controller.dart';
import 'package:stadium/home/pages/clubes_page.dart';
import 'package:stadium/home/pages/create_estadio_page.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/models/estadios.dart';

class EstadioPage extends StatelessWidget {
  final Estadios estadio;
  const EstadioPage({
    Key? key,
    required this.estadio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Modular.get();
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(estadio.nome),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                estadio.imagem,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    _buildInfo(),
                    const Divider(
                      thickness: 0.1,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildTime(),
                    const SizedBox(
                      height: 20,
                    ),
                    titleSubtitle(
                        estadio.capacidade ?? '', 'Capacidade', Icons.people),
                    const SizedBox(
                      height: 20,
                    ),
                    titleSubtitle(
                        estadio.localizacao, 'Localização', Icons.location_on),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildMap(),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.nomeController.text = estadio.nome;
                            controller.descricaoController.text =
                                estadio.descricao;
                            controller.capacidadeMax.text =
                                estadio.capacidade ?? '';
                            controller.imagemUrlController.text =
                                estadio.imagem;
                            controller.cidadeController.text =
                                estadio.localizacao;
                            controller.enderecoController.text =
                                estadio.endereco;
                            controller.latitudeController.text =
                                estadio.lat.toString();
                            controller.longitudeController.text =
                                estadio.long.toString();
                            Modular.to.push(MaterialPageRoute(
                                builder: (context) => CreateEstadio(
                                      nome: estadio.nome,
                                      isEdit: true,
                                    )));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff09554B)),
                          child: const Text('Editar Estádio')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.deleteEstadios(estadio.nome);
                        await controller.getEstadios();
                        Modular.to.pop();
                      },
                      child: const Center(
                        child: Text('Excluir estádio',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff09554B),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          estadio.nome,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          estadio.descricao,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget titleSubtitle(String title, String subtitle, IconData icons) {
    return Row(
      children: [
        Icon(
          icons,
          color: Colors.black,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTime() {
    return GestureDetector(
      onTap: () async {
        final HomeController controller = Modular.get();
        Clubes clube = await controller.getClubById(estadio.clubId);
        Modular.to.push(
            MaterialPageRoute(builder: (context) => ClubePage(clube: clube)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleSubtitle(
              estadio.clubNome, 'Clube de Futebol', Icons.sports_soccer),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Localização Mapa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 3,
          ),
          Text('Não sabe como chegar? Veja o mapa abaixo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.5),
              )),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 200,
            child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(estadio.lat, estadio.long),
                  initialZoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(estadio.lat, estadio.long),
                        child: const Icon(
                          Icons.location_on,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(estadio.endereco,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              )),
        ],
      ),
    );
  }
}
