import 'package:flutter_modular/flutter_modular.dart';
import '../../core/storage/storage.dart';
import '../../core/storage/storage_impl.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/auth_repository_impl.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthRepository>(
          (i) => AuthRepositoryImpl(i()),
          export: true,
        ),
        Bind.lazySingleton<Storage>(
          (i) => SessionStorage(),
          export: true,
        ),
      ];
}
