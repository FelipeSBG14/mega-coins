import 'package:flutter_modular/flutter_modular.dart';
import '../../services/auth/login_service.dart';
import '../../services/auth/login_service_impl.dart';
import '../../services/players/players_service.dart';
import '../../services/players/players_service_impl.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<LoginService>(
          (i) => LoginServiceImpl(i()),
        ),
        Bind.lazySingleton<PlayersService>(
          (i) => PlayersServiceImpl(i()),
        ),
        Bind.lazySingleton(
          (i) => HomeController(i(), i(), i()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
