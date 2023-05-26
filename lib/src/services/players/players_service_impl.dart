import '../../models/players_model.dart';
import '../../repositories/players/players_repository.dart';
import './players_service.dart';

class PlayersServiceImpl implements PlayersService {
  final PlayersRepository _playersRepository;
  PlayersServiceImpl(
    this._playersRepository,
  );
  @override
  Future<List<PlayersModel>> getPlayers(String? name) =>
      _playersRepository.getPlayers(name);
  @override
  Future<void> addOrEditPlayers(id, name, coins) =>
      _playersRepository.addOrEditPlayers(id, name, coins);

  @override
  Future<void> playerDelete(id) => _playersRepository.playerDelete(id);
}
