import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/home/home_controller.dart';
import 'package:stadium/home/pages/home_page.dart';
import 'package:stadium/home/repository/home_repository.dart';

class HomeMoudle extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeRepository()),
        Bind((i) => HomeController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => const HomePage(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
