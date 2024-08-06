import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:stadium/home/pages/create_clube.dart';
import 'package:stadium/home/pages/create_estadio_page.dart';
import 'package:stadium/home/repository/home_repository.dart';
import 'package:stadium/local_service.dart';
import 'package:stadium/models/clubes.dart';
import 'package:stadium/models/estadios.dart';
import 'package:stadium/models/jogadores.dart';
import 'package:stadium/services/shared_prefs.dart';
import 'package:stadium/utils/status.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final HomeRepository repository = Modular.get();
  final LocationService locationService = LocationService();

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
  String? localizacao;

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

  @observable
  Status statusLocalizacao = Status.empty;

  @observable
  Status statusPostClube = Status.empty;

  @observable
  bool estadiosProximos = false;

  @action
  void setEstadioProximos(bool value) => estadiosProximos = value;

  void createNew() => valorSelecionado == 1
      ? Modular.to
          .push(MaterialPageRoute(builder: (context) => const CreateClube()))
      : Modular.to
          .push(MaterialPageRoute(builder: (context) => const CreateEstadio()));

  @action
  Future init() async {
    return Future.wait([getEstadios(), getLocation(), getClubes()]);
  }

  @action
  Future getLocation() async {
    try {
      statusLocalizacao = Status.loading;
      localizacao = await locationService.getCurrentAddress();
      statusLocalizacao = Status.success;
    } on Exception {
      statusLocalizacao = Status.error;
    }
  }

  @action
  void setValorSelecionado(int? value) => valorSelecionado = value ?? 0;

  @action
  Future postClube(Clubes clube) async {
    try {
      statusPostClube = Status.loading;
      await repository.postClube(clube);
      statusPostClube = Status.success;
    } on Exception {
      statusPostClube = Status.error;
    }
  }

  @action
  Future postJogador(List<Jogador> jogador, String id) async {
    try {
      await repository.postJogador(jogador, id);
    } on Exception catch (e) {
      print(e);
    }
  }

  @action
  Future getClubes() async {
    try {
      clubes = await repository.getClubes();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future postEstadio(Estadios estadio) async {
    try {
      await repository.postEstadio(estadio);
    } on Exception catch (e) {
      print(e);
    }
  }

  @action
  Future getEstadios() async {
    try {
      estadios = await repository.getEstadios();
    } on Exception catch (e) {
      print(e);
    }
  }

  @action
  Future getClubById(String id) async {
    try {
      return await repository.getClubeById(id);
    } on Exception catch (e) {
      print(e);
    }
  }

  @action
  Future deleteEstadios(String nome) async {
    try {
      return await repository.deleteEstadio(nome);
    } on Exception catch (e) {
      print(e);
    }
  }

  @action
  Future patchEstadios(Estadios estadio, String nome) async {
    try {
      return await repository.patchEstadio(nome, estadio);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future logout() async {
    final SharedPrefsService sharedPrefs = SharedPrefsService();
    await sharedPrefs.remove();
    Modular.to.pushReplacementNamed('/');
  }
}
