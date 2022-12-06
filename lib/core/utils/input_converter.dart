class InputConverter {
  Future<int> stringToUnsignedInteger(String str) async {
    final integer = int.parse(str);
    if (integer < 0) throw const FormatException();
    return Future.value(int.parse(str));
  }
}
