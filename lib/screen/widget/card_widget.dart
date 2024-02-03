import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String message;
  final String? val;
  const CardWidget({
    required this.val,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          color: message.compareTo('Current Second') == 0 ||
              message.compareTo('Random Number') == 0
              ? Colors.blueGrey
              : message.compareTo("Sucess") == 0
              ? Colors.green
              : Colors.orangeAccent,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 10,
                endIndent: 0,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: message.compareTo("Current Second") == 0 ||
                    message.compareTo("Random Number") == 0
                    ? Text(
                  val!,
                  style: const TextStyle(fontSize: 24),
                )
                    : message.compareTo("Success") == 0
                    ? Text(
                  "Score : ${val!}",
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                )
                    : Text(
                  "Attempt : ${val!}",
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
