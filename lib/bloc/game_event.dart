part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

final class ButtonClickedEvent extends GameEvent{}

final class TimedOutEvent extends GameEvent{}

final class DataFetchEvent extends GameEvent{}