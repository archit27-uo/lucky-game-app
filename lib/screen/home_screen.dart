import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:luckygame/screen/widget/card_widget.dart';
import '../Model/game_state_model.dart';
import '../bloc/game_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CountDownController _controller = CountDownController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Hive.box<GameStateModel>('game3').get(1) != null) {
      context.read<GameBloc>().add(DataFetchEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardWidget(
                    val: state.store.listGame?.currentSecond.toString(),
                    message: "Current Second",
                  ),
                  CardWidget(
                    val: state.store.listGame?.randomNumberGenerated.toString(),
                    message: "Random Number",
                  ),
                ],
              ),
              CardWidget(
                val:
                "${state.store.listGame!.win}/${state.store.listGame!.totalAttempt}",
                message: state.store.listGame!.message,
              ),
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: CircularCountDownTimer(
                  controller: _controller,
                  onComplete: () {
                    context.read<GameBloc>().add(TimedOutEvent());
                  },
                  width: 150,
                  height: 150,
                  duration: 5,
                  fillColor: Colors.green,
                  ringColor: Colors.black26,
                  textStyle: const TextStyle(fontSize: 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    _controller.restart(duration: 5);
                    context.read<GameBloc>().add(ButtonClickedEvent());
                  },
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Click Me',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
