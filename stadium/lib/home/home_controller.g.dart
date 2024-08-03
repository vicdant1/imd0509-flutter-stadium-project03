// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$valorSelecionadoAtom =
      Atom(name: '_HomeControllerBase.valorSelecionado', context: context);

  @override
  int get valorSelecionado {
    _$valorSelecionadoAtom.reportRead();
    return super.valorSelecionado;
  }

  @override
  set valorSelecionado(int value) {
    _$valorSelecionadoAtom.reportWrite(value, super.valorSelecionado, () {
      super.valorSelecionado = value;
    });
  }

  late final _$idSelecionadoAtom =
      Atom(name: '_HomeControllerBase.idSelecionado', context: context);

  @override
  String get idSelecionado {
    _$idSelecionadoAtom.reportRead();
    return super.idSelecionado;
  }

  @override
  set idSelecionado(String value) {
    _$idSelecionadoAtom.reportWrite(value, super.idSelecionado, () {
      super.idSelecionado = value;
    });
  }

  late final _$valorDropDownAtom =
      Atom(name: '_HomeControllerBase.valorDropDown', context: context);

  @override
  String get valorDropDown {
    _$valorDropDownAtom.reportRead();
    return super.valorDropDown;
  }

  @override
  set valorDropDown(String value) {
    _$valorDropDownAtom.reportWrite(value, super.valorDropDown, () {
      super.valorDropDown = value;
    });
  }

  late final _$clubesAtom =
      Atom(name: '_HomeControllerBase.clubes', context: context);

  @override
  List<Clubes> get clubes {
    _$clubesAtom.reportRead();
    return super.clubes;
  }

  @override
  set clubes(List<Clubes> value) {
    _$clubesAtom.reportWrite(value, super.clubes, () {
      super.clubes = value;
    });
  }

  late final _$jogadoresAtom =
      Atom(name: '_HomeControllerBase.jogadores', context: context);

  @override
  List<Jogador> get jogadores {
    _$jogadoresAtom.reportRead();
    return super.jogadores;
  }

  @override
  set jogadores(List<Jogador> value) {
    _$jogadoresAtom.reportWrite(value, super.jogadores, () {
      super.jogadores = value;
    });
  }

  late final _$estadiosAtom =
      Atom(name: '_HomeControllerBase.estadios', context: context);

  @override
  List<Estadios> get estadios {
    _$estadiosAtom.reportRead();
    return super.estadios;
  }

  @override
  set estadios(List<Estadios> value) {
    _$estadiosAtom.reportWrite(value, super.estadios, () {
      super.estadios = value;
    });
  }

  late final _$getClubesAsyncAction =
      AsyncAction('_HomeControllerBase.getClubes', context: context);

  @override
  Future<dynamic> getClubes() {
    return _$getClubesAsyncAction.run(() => super.getClubes());
  }

  late final _$getEstadiosAsyncAction =
      AsyncAction('_HomeControllerBase.getEstadios', context: context);

  @override
  Future<dynamic> getEstadios() {
    return _$getEstadiosAsyncAction.run(() => super.getEstadios());
  }

  late final _$getClubByIdAsyncAction =
      AsyncAction('_HomeControllerBase.getClubById', context: context);

  @override
  Future<dynamic> getClubById(String id) {
    return _$getClubByIdAsyncAction.run(() => super.getClubById(id));
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  void setValorSelecionado(int? value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setValorSelecionado');
    try {
      return super.setValorSelecionado(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> deleteEstadios(String nome) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.deleteEstadios');
    try {
      return super.deleteEstadios(nome);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> patchEstadios(Estadios estadio, String nome) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.patchEstadios');
    try {
      return super.patchEstadios(estadio, nome);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
valorSelecionado: ${valorSelecionado},
idSelecionado: ${idSelecionado},
valorDropDown: ${valorDropDown},
clubes: ${clubes},
jogadores: ${jogadores},
estadios: ${estadios}
    ''';
  }
}
