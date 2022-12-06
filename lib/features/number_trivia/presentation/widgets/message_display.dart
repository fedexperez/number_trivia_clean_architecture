import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      height: size.height * 0.3,
      width: size.width,
      margin: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Text(
          message,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
