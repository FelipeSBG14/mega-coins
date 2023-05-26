// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/env/env.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../models/players_model.dart';
import './players_repository.dart';

class PlayersRepositoryImpl implements PlayersRepository {
  final _dio = Dio();
  String baseUrl = Env.instance.get('backend_base_url');
  @override
  Future<List<PlayersModel>> getPlayers(String? name) async {
    try {
      final List<PlayersModel> _playersList = [];
      final response = await _dio.get(
        '$baseUrl/players.json',
      );
      final Map<String, dynamic>? data = response.data;
      if (data != null) {
        data.forEach(
          (playerId, playerData) {
            _playersList.add(
              PlayersModel(
                id: playerId,
                name: playerData['name'],
                coins: playerData['coins'],
              ),
            );
          },
        );
      }
      return _playersList;
    } catch (e, s) {
      log('Não deu para buscar os jogadores', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar jogadores');
    }
  }

  @override
  Future<void> addOrEditPlayers(id, name, coins) async {
    try {
      PlayersModel player = PlayersModel(name: name, coins: coins);
      if (id == null) {
        player = PlayersModel(
          id: math.Random().nextDouble().toString(),
          name: name,
          coins: coins,
        );
      } else {
        player = PlayersModel(
          id: id,
          name: name,
          coins: coins,
        );
      }
      if (id != null) {
        await _dio.patch(
          '$baseUrl/players/$id.json',
          data: {
            'name': player.name,
            'coins': player.coins,
          },
        );
      } else {
        await _dio.post(
          '$baseUrl/players.json',
          data: {
            'id': player.id,
            'name': player.name,
            'coins': player.coins,
          },
        );
      }
    } on DioError catch (e, s) {
      log('Aconteceu um erro na requisição', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro na requisição');
    } catch (e, s) {
      log('Não deu para adicionar o jogador', error: e, stackTrace: s);
      debugPrint(e.toString());
      throw RepositoryException(message: 'Erro ao buscar jogadores');
    }
  }

  @override
  Future<void> playerDelete(id) async {
    try {
      if (id != null) {
        await _dio.delete(
          '$baseUrl/players/$id.json',
        );
      } else {
        throw RepositoryException(message: 'Id não identificado');
      }
    } on DioError catch (e, s) {
      log('Aconteceu um erro na requisição', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro na requisição');
    } catch (e, s) {
      log('Não deu para adicionar o jogador', error: e, stackTrace: s);
      debugPrint(e.toString());
      throw RepositoryException(message: 'Erro ao buscar jogadores');
    }
  }
}
