part of 'game_bloc.dart';

@immutable
abstract class GameState {
  final GameStateStore store;

  const GameState({required this.store});
}

class GameInitial extends GameState {
  const GameInitial({
    required GameStateStore store,
  }) : super(store: store);
}

class GameUpdate extends GameState {
  const GameUpdate({
    required GameStateStore store,
  }) : super(store: store);
}

final class GameStateStore {
  final GameStateModel? listGame;
  const GameStateStore({this.listGame});

  GameStateStore copyWith({
    GameStateModel? listGame,
  }) {
    return GameStateStore(
      listGame: listGame ?? this.listGame,
    );
  }
}
