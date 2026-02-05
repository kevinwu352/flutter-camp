class Counter {
  int value = 0;

  void increase() => value++;

  void decrease() => value--;

  Future<int> getval() async {
    await Future.delayed(Duration(seconds: 2));
    return 10;
  }
}
