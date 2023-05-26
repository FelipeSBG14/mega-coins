// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:mobx/mobx.dart';
import '../../core/exceptions/auth_exception.dart';
import '../../services/auth/login_service.dart';

part 'login_controller.g.dart';

enum LoginStateStatus {
  inital,
  loading,
  success,
  error;
}

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginService _loginService;

  @readonly
  LoginStateStatus _loginStatus = LoginStateStatus.inital;

  @readonly
  String? _errorMessage;

  @observable
  bool showPassword = false;

  LoginControllerBase(this._loginService);

  @action
  Future<void> login(String email, String password) async {
    try {
      _loginStatus = LoginStateStatus.loading;
      await _loginService.login(email, password);
      _loginStatus = LoginStateStatus.success;
    } on AuthException catch (e, s) {
      log('Login ou senha inválidos', error: e, stackTrace: s);
      _errorMessage = 'Login ou senha inválidos';
      _loginStatus = LoginStateStatus.error;
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      _errorMessage = 'Erro desconhecido';
      _loginStatus = LoginStateStatus.error;
    }
  }

  @action
  bool showOrHidePassword() => showPassword = !showPassword;
}
