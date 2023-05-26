import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth/auth_repository.dart';
import './login_service.dart';

class LoginServiceImpl implements LoginService {
  final AuthRepository _authRepository;

  LoginServiceImpl(this._authRepository);

  @override
  Future<User?> login(String email, String password) =>
      _authRepository.login(email, password);

  @override
  Future<User?> getUser() => _authRepository.getUser();
}
