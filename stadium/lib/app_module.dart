import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/autenticacao/autenticacao_modula.dart';
import 'package:stadium/home/home_module.dart';
import 'package:stadium/services/firebase_msg_service.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds =>
      [Bind.lazySingleton((i) => FirebaseMessagingService())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Modular.initialRoute,
          module: AutenticacaoModule(),
          transition: TransitionType.fadeIn,
        ),
        ModuleRoute(
          '/home',
          module: HomeMoudle(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
