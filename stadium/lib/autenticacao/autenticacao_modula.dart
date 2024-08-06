import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/autenticacao/autenticacao_controller.dart';
import 'package:stadium/autenticacao/autenticacao_page.dart';
import 'package:stadium/autenticacao/autenticacao_repository.dart';
import 'package:stadium/autenticacao/cadastro_page.dart';
import 'package:stadium/services/firebase_msg_service.dart';

class AutenticacaoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<AutenticacaoRepository>(
          (i) => AutenticacaoRepository(),
        ),
        Bind(
          (i) => AutenticacaoController(),
        ),
        Bind(
          (i) => FirebaseMessagingService(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => const AutenticacaoPage(),
        ),
        ChildRoute(
          '/cadastro',
          child: (_, args) => const CadastroPage(),
        ),
      ];
}
