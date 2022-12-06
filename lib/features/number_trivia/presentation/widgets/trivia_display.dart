import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({
    Key? key,
    required this.numberTrivia,
  }) : super(key: key);

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      height: size.height * 0.3,
      width: size.width,
      margin: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              numberTrivia.number.toString(),
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              numberTrivia.text,
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
