// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autenticacao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AutenticacaoController on _AutenticacaoControllerBase, Store {
  late final _$usuarioLogadoAtom =
      Atom(name: '_AutenticacaoControllerBase.usuarioLogado', context: context);

  @override
  Users? get usuarioLogado {
    _$usuarioLogadoAtom.reportRead();
    return super.usuarioLogado;
  }

  @override
  set usuarioLogado(Users? value) {
    _$usuarioLogadoAtom.reportWrite(value, super.usuarioLogado, () {
      super.usuarioLogado = value;
    });
  }

  late final _$fotoPerfilAtom =
      Atom(name: '_AutenticacaoControllerBase.fotoPerfil', context: context);

  @override
  File? get fotoPerfil {
    _$fotoPerfilAtom.reportRead();
    return super.fotoPerfil;
  }

  @override
  set fotoPerfil(File? value) {
    _$fotoPerfilAtom.reportWrite(value, super.fotoPerfil, () {
      super.fotoPerfil = value;
    });
  }

  late final _$fotoPerfilCadastroAtom = Atom(
      name: '_AutenticacaoControllerBase.fotoPerfilCadastro', context: context);

  @override
  File? get fotoPerfilCadastro {
    _$fotoPerfilCadastroAtom.reportRead();
    return super.fotoPerfilCadastro;
  }

  @override
  set fotoPerfilCadastro(File? value) {
    _$fotoPerfilCadastroAtom.reportWrite(value, super.fotoPerfilCadastro, () {
      super.fotoPerfilCadastro = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AutenticacaoControllerBase.login', context: context);

  @override
  Future<dynamic> login(String email, String senha, BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(email, senha, context));
  }

  late final _$converteBase64ParaFileAsyncAction = AsyncAction(
      '_AutenticacaoControllerBase.converteBase64ParaFile',
      context: context);

  @override
  Future<dynamic> converteBase64ParaFile(String? base64) {
    return _$converteBase64ParaFileAsyncAction
        .run(() => super.converteBase64ParaFile(base64));
  }

  late final _$verificaPersistenciaAsyncAction = AsyncAction(
      '_AutenticacaoControllerBase.verificaPersistencia',
      context: context);

  @override
  Future<dynamic> verificaPersistencia() {
    return _$verificaPersistenciaAsyncAction
        .run(() => super.verificaPersistencia());
  }

  @override
  String toString() {
    return '''
usuarioLogado: ${usuarioLogado},
fotoPerfil: ${fotoPerfil},
fotoPerfilCadastro: ${fotoPerfilCadastro}
    ''';
  }
}
