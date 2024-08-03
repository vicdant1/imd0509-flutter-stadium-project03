import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:stadium/home/repository/home_repository.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/models/estadios.dart';
import 'package:stadium/models/jogadores.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final HomeRepository repository = Modular.get();

  final nomeController = TextEditingController();
  final imagemUrlController = TextEditingController();

  final descricaoController = TextEditingController();
  final cidadeController = TextEditingController();
  final enderecoController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final capacidadeMax = TextEditingController();

  final tituloController = TextEditingController();

  final posicaoController = TextEditingController();

  @observable
  int valorSelecionado = 0;

  @observable
  String idSelecionado = '';

  @observable
  String valorDropDown = '';

  @observable
  List<Clubes> clubes = [];

  @observable
  List<Jogador> jogadores = [];

  @observable
  List<Estadios> estadios = [];

  @action
  void setValorSelecionado(int? value) => valorSelecionado = value ?? 0;

  Future postClube(Clubes clube) async {
    await repository.postClube(clube);
  }

  Future postJogador(List<Jogador> jogador, String id) async {
    await repository.postJogador(jogador, id);
  }

  @action
  Future getClubes() async {
    clubes = await repository.getClubes();
  }

  Future postEstadio(Estadios estadio) async {
    await repository.postEstadio(estadio);
  }

  @action
  Future getEstadios() async {
    estadios = await repository.getEstadios();
  }

  @action
  Future getClubById(String id) async {
    return await repository.getClubeById(id);
  }

  @action
  Future deleteEstadios(String nome) {
    return repository.deleteEstadio(nome);
  }

  @action
  Future patchEstadios(Estadios estadio, String nome) {
    return repository.patchEstadio(nome, estadio);
  }
}
