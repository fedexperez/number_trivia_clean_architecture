import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (value) {
              addConcreteNumber;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: addConcreteNumber,
                  child: const Text('Search'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade500,
                  ),
                  onPressed: addRandomNumber,
                  child: const Text('Get random trivia'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void addConcreteNumber() {
    controller.clear();
    context
        .read<NumberTriviaBloc>()
        .add(GetTriviaForConcreteNumberEvent(numberString: inputStr));
  }

  void addRandomNumber() {
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumberEvent());
  }
}
