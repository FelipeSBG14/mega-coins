// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/global/constants.dart';
import '../../core/storage/storage.dart';
import '../../models/players_model.dart';
import '../../services/auth/login_service.dart';
import '../../services/players/players_service.dart';

part 'home_controller.g.dart';

enum HomeStateStatus {
  inital,
  loading,
  success,
  error;
}

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final Storage storage;
  final LoginService _loginService;
  final PlayersService _playersService;

  @readonly
  HomeStateStatus _homeStatus = HomeStateStatus.inital;

  @observable
  User? currentUser;

  @observable
  bool isLoading = false;

  @readonly
  List<PlayersModel>? _playersList;

  @readonly
  List<PlayersModel>? _playersSearch;

  @readonly
  String? _filterName;

  @readonly
  String? _refreshToken;

  @readonly
  String? _errorMessage;

  HomeControllerBase(this._loginService, this.storage, this._playersService);

  @action
  void filterByName(String name) {
    _playersSearch = _playersList
        ?.where(
          (p) =>
              (p.name).trim().toUpperCase().contains(name.trim().toUpperCase()),
        )
        .toList();
  }

  @action
  Future<void> getInformation() async {
    try {
      await findAllPlayers();
      currentUser = await _loginService.getUser();
      _refreshToken = storage.getData(SessionStorageKeys.accessToken.key);
      _homeStatus = HomeStateStatus.success;
    } on FirebaseAuthException catch (e, s) {
      log(
        'Não foi possível trazer os dados do usuário',
        error: e,
        stackTrace: s,
      );
      _errorMessage = e.message;
      _homeStatus = HomeStateStatus.error;
    } catch (e, s) {
      log(
        'Erro desconhecido ao buscar dados do usuário',
        error: e,
        stackTrace: s,
      );

      _errorMessage = 'Erro desconhecido';
      _homeStatus = HomeStateStatus.error;
    }
  }

  @action
  Future<void> findAllPlayers() async {
    try {
      _playersList = await _playersService.getPlayers(_filterName);
      orderList(_playersList);
      _playersSearch = _playersList;
      debugPrint('Lista de Jogadores $_playersList');
    } on FirebaseException catch (e, s) {
      log('Não foi possível achar os jogadores', error: e, stackTrace: s);
      _errorMessage = 'Não foi possível achar os jogadores';
      _playersList = [];
    } catch (e, s) {
      log('Erro ao buscar jogadores', error: e, stackTrace: s);
      _errorMessage = 'Erro ao buscar jogadores';
      _playersList = [];
    }
  }

  @action
  Future<void> addPlayers(id, name, coins) async {
    try {
      await _playersService.addOrEditPlayers(id, name, coins);
      _homeStatus = HomeStateStatus.loading;
      await findAllPlayers();
      _homeStatus = HomeStateStatus.success;
    } on FirebaseException catch (e, s) {
      log('Não foi possível achar os jogadores', error: e, stackTrace: s);
      _errorMessage = e.message;
      _homeStatus = HomeStateStatus.error;
    }
  }

  @action
  List<void>? orderList(List<PlayersModel>? players) {
    try {
      _playersList = players?.toList();
      _playersList?.sort((a, b) => b.coins.compareTo(a.coins));
    } catch (e, s) {
      log('Erro ao ordenar lista', error: e, stackTrace: s);
      _errorMessage = 'Erro na lista';
      _playersList = [];
    }
    return null;
  }

  @action
  Future<void> playerDelete(id) async {
    try {
      _homeStatus = HomeStateStatus.loading;
      await _playersService.playerDelete(id);
      await findAllPlayers();
      _homeStatus = HomeStateStatus.success;
    } on RepositoryException catch (e, s) {
      log(
        'Erro ao deletar jogador',
        error: e,
        stackTrace: s,
      );
      _errorMessage = e.message;
      _homeStatus = HomeStateStatus.error;
    }
  }
}
