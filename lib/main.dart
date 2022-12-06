import 'injection_container.dart' as di;
import 'package:flutter/material.dart';

import 'package:clean_architecture/features/number_trivia/presentation/screens/number_trivia_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const NumberTriviaScreen(),
    );
  }
}
