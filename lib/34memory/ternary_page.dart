class TernaryObj {
  TernaryObj({this.abc = ''}) : _bbc = '';

  // final & private 的成员变量，在三元运算符中，判断不空时，后面能用不空的实例，不用加问号了
  final String? abc;
  final String? _bbc;
  void doit() {
    // final val1 = abc is String ? abc.isEmpty : false;
    // print(val1);
    final val2 = _bbc is String ? _bbc.isEmpty : false;
    print(val2);
  }
}
