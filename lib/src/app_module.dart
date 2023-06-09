import 'package:flutter_modular/flutter_modular.dart';
import 'modules/core/core_module.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/login',
          module: LoginModule(),
        ),
        ModuleRoute(
          '/home/',
          module: HomeModule(),
        ),
      ];
}
