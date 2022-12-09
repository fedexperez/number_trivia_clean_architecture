class InputConverter {
  Future<int> stringToUnsignedInteger(String str) async {
    try {
      final int integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Future.value(integer);
    } on FormatException {
      throw const FormatException();
    }
  }
}
