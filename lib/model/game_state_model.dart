

import 'package:hive/hive.dart';
part 'game_state_model.g.dart';
@HiveType(typeId: 0)
final class GameStateModel {
  @HiveField(0)
  final int? currentSecond;
  @HiveField(1)
  final int? randomNumberGenerated;
  @HiveField(2)
  final int? totalAttempt;
  @HiveField(3)
  final int? win;
  @HiveField(4)
  final String message;
  GameStateModel(
      this.currentSecond,
      this.randomNumberGenerated,
      this.totalAttempt,
      this.win,
      this.message,
      );
}