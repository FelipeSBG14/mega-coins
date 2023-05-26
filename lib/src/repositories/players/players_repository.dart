import '../../models/players_model.dart';

abstract class PlayersRepository {
  Future<List<PlayersModel>> getPlayers(String? name);
  Future<void> addOrEditPlayers(id, name, coins);
  Future<void> playerDelete(id);
}
