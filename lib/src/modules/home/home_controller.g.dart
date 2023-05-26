// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$_homeStatusAtom =
      Atom(name: 'HomeControllerBase._homeStatus', context: context);

  HomeStateStatus get homeStatus {
    _$_homeStatusAtom.reportRead();
    return super._homeStatus;
  }

  @override
  HomeStateStatus get _homeStatus => homeStatus;

  @override
  set _homeStatus(HomeStateStatus value) {
    _$_homeStatusAtom.reportWrite(value, super._homeStatus, () {
      super._homeStatus = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: 'HomeControllerBase.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_playersListAtom =
      Atom(name: 'HomeControllerBase._playersList', context: context);

  List<PlayersModel>? get playersList {
    _$_playersListAtom.reportRead();
    return super._playersList;
  }

  @override
  List<PlayersModel>? get _playersList => playersList;

  @override
  set _playersList(List<PlayersModel>? value) {
    _$_playersListAtom.reportWrite(value, super._playersList, () {
      super._playersList = value;
    });
  }

  late final _$_refreshTokenAtom =
      Atom(name: 'HomeControllerBase._refreshToken', context: context);

  String? get refreshToken {
    _$_refreshTokenAtom.reportRead();
    return super._refreshToken;
  }

  @override
  String? get _refreshToken => refreshToken;

  @override
  set _refreshToken(String? value) {
    _$_refreshTokenAtom.reportWrite(value, super._refreshToken, () {
      super._refreshToken = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: 'HomeControllerBase._errorMessage', context: context);

  String? get errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  String? get _errorMessage => errorMessage;

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$getInformationAsyncAction =
      AsyncAction('HomeControllerBase.getInformation', context: context);

  @override
  Future<void> getInformation() {
    return _$getInformationAsyncAction.run(() => super.getInformation());
  }

  late final _$findAllPlayersAsyncAction =
      AsyncAction('HomeControllerBase.findAllPlayers', context: context);

  @override
  Future<void> findAllPlayers() {
    return _$findAllPlayersAsyncAction.run(() => super.findAllPlayers());
  }

  late final _$addPlayersAsyncAction =
      AsyncAction('HomeControllerBase.addPlayers', context: context);

  @override
  Future<void> addPlayers(dynamic id, dynamic name, dynamic coins) {
    return _$addPlayersAsyncAction.run(() => super.addPlayers(id, name, coins));
  }

  late final _$playerDeleteAsyncAction =
      AsyncAction('HomeControllerBase.playerDelete', context: context);

  @override
  Future<void> playerDelete(dynamic id) {
    return _$playerDeleteAsyncAction.run(() => super.playerDelete(id));
  }

  late final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase', context: context);

  @override
  List<void>? orderList(List<PlayersModel>? players) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.orderList');
    try {
      return super.orderList(players);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isLoading: ${isLoading}
    ''';
  }
}
