import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_controlls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia/number_trivia_bloc.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:clean_architecture/injection_container.dart';

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
        centerTitle: false,
      ),
      body: const SingleChildScrollView(child: BuildBody()),
    );
  }
}

class BuildBody extends StatelessWidget {
  const BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Column(
        children: [
          //Top
          BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
            builder: (context, state) {
              if (state is NumberTriviaInitialState) {
                return const MessageDisplay(message: 'Start searching');
              } else if (state is LoadingState) {
                return const LoadingWidget();
              } else if (state is LoadedState) {
                return TriviaDisplay(numberTrivia: state.trivia);
              } else if (state is ErrorState) {
                return MessageDisplay(message: state.errorMessage);
              }
              return const MessageDisplay(message: '');
            },
          ),
          const TriviaControls(),
        ],
      ),
    );
  }
}
