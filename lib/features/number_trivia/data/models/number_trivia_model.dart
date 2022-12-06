import 'dart:convert';

import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    required this.textm,
    required this.numberm,
    this.found,
    this.type,
  }) : super(
          number: numberm,
          text: textm,
        );

  String textm;
  int numberm;
  bool? found;
  String? type;

  factory NumberTriviaModel.fromJson(String str) =>
      NumberTriviaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NumberTriviaModel.fromMap(Map<String, dynamic> json) =>
      NumberTriviaModel(
        textm: json["text"],
        numberm: (json["number"] as num).toInt(),
        // found: json["found"],
        // type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "number": number,
        // "found": found,
        // "type": type,
      };
}
