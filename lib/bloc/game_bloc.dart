import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../Model/game_state_model.dart';
import '../Repository/local_data_source.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameDataBase gameDataBase;
  // print("Inside ")
  GameBloc(this.gameDataBase)
      : super(
    GameInitial(
      store: GameStateStore(
        listGame: GameStateModel(
          0,
          0,
          0,
          0,
          'Start',
        ),
      ),
    ),
  ) {
    on<DataFetchEvent>(_onDataFetchEvent);
    on<ButtonClickedEvent>(_onButtonClickedEvent);
    on<TimedOutEvent>(_onTimedOutEvent);
  }


  void _onDataFetchEvent(DataFetchEvent event, Emitter<GameState> emit) async {
    emit(GameInitial(
      store: GameStateStore(
        listGame: await gameDataBase.loadData(),
      ),
    ),
    );
  }



  void _onButtonClickedEvent(
      ButtonClickedEvent event, Emitter<GameState> emit) {
    int randomNumber = Random().nextInt(60);
    DateTime timeStamp = DateTime.now();
    String formattedDate =
    DateFormat('kk:mm:ss \n EEE d MMM').format(timeStamp);
    int currentSecond = int.parse(formattedDate.substring(6, 8));
    if (currentSecond == randomNumber) {
      emit(
        GameUpdate(
          store: GameStateStore(
            listGame: GameStateModel(
                randomNumber,
                currentSecond,
                state.store.listGame!.totalAttempt!,
                state.store.listGame!.win! + 1,
                'Success :)'),
          ),
        ),
      );
      gameDataBase.updateData(
        state.store.listGame!,
      );
    } else {
      emit(
        GameUpdate(
          store: GameStateStore(
            listGame: GameStateModel(
                randomNumber,
                currentSecond,
                state.store.listGame!.totalAttempt!,
                state.store.listGame!.win!,
                'Sorry try Again'),
          ),
        ),
      );
      gameDataBase.updateData(
        state.store.listGame!,
      );
    }
  }



  void _onTimedOutEvent(TimedOutEvent event, Emitter<GameState> emit) {
    emit(
      GameUpdate(
        store: GameStateStore(
          listGame: GameStateModel(
            state.store.listGame!.randomNumberGenerated,
            state.store.listGame!.currentSecond,
            state.store.listGame!.totalAttempt! + 1,
            state.store.listGame!.win!,
            'Timed out',
          ),
        ),
      ),
    );
  }
}
