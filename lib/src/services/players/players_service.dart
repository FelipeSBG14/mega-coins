import '../../models/players_model.dart';

abstract class PlayersService {
  Future<List<PlayersModel>> getPlayers(String? name);
  Future<void> addOrEditPlayers(id, name, coins);
  Future<void> playerDelete(id);
}
