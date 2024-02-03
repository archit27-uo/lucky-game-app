import 'package:hive_flutter/hive_flutter.dart';
import '../Model/game_state_model.dart';

class GameDataBase {
  Future<GameStateModel?> loadData() async {
    if (await Hive.box<GameStateModel>('game3').get(1) == null) {
      return null;
    } else {
      return await Hive.box<GameStateModel>('game3').get(1);
    }
  }

  void updateData(GameStateModel gsm) async {
    Hive.box<GameStateModel>('game3').put(1, gsm);
  }
}
