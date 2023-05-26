import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/storage/storage.dart';
import '../../core/storage/storage_impl.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/auth_repository_impl.dart';

import '../../services/auth/login_service.dart';
import '../../services/auth/login_service_impl.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthRepository>(
          (i) => AuthRepositoryImpl(FirebaseAuth.instance, i()),
        ),
        Bind.lazySingleton<LoginService>(
          (i) => LoginServiceImpl(i()),
        ),
        Bind.lazySingleton<Storage>(
          (i) => SessionStorage(),
        ),
        Bind.lazySingleton((i) => LoginController(i())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const LoginPage(),
        )
      ];
}
