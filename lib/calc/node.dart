import 'package:calculator/calc/token.dart';

class Node {
  Node left, right, parent;
  Token _data;

  Node(this._data);

  Token get data => _data;

  @override
  String toString() {
    return '[Data:$_data, , [Left: $left], [Right: $right]]';
  }
}
