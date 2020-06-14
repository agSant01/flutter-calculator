import 'package:calculator/calc/node.dart';

import 'tokenizer.dart';
import 'token_type.dart';
import 'token.dart';

class Calc {
  double _result;

  Node root = Node(null);
  Node currentNode;

  List<Token> _tokenList = List();

  void addElement(String element) {
    if (element.length == 0) return;

    Token token = Tokenizer.tokenize(element)[0];

    Node newNode = Node(token);
    _positionElement(newNode);
    _tokenList.add(token);
  }

  static double calculateTemp(Calc calc, String operand, String element) {
    Calc newCalc = Calc();
    print(calc.tokens);
    for (Token t in calc.tokens) {
      newCalc.addElement(t.data);
    }
    newCalc.addElement(operand);
    newCalc.addElement(element);
    return newCalc.calculate();
  }

  double calculate() {
    _result = _calculate(root);
    return _result;
  }

  List<Token> get tokens => _tokenList.map((t) => t).toList();

  void clear() {
    _tokenList.clear();
    root = Node(null);
  }

  void _positionElement(Node node) {
    if (root.data == null) {
      if (_isOperator(node.data)) throw Exception("Cant start with operator");
      root = node;
      currentNode = root;
    } else if (!_isOperator(root.data)) {
      root.parent = node;
      node.left = root;
      root = currentNode = node;
    } else if (!_isOperator(node.data)) {
      if (currentNode.left == null) {
        currentNode.left = node;
      } else if (currentNode.right == null) {
        currentNode.right = node;
      }
      node.parent = currentNode;
    } else if (node.data.type.priority >= currentNode.data.type.priority) {
      node.left = currentNode.right;
      currentNode.right.parent = node;
      currentNode.right = node;
      node.parent = currentNode;
      currentNode = node;

      while (currentNode.parent.data.type.priority ==
          currentNode.data.type.priority) {
        var parentOfCurrent = currentNode.parent;
        var current = currentNode;
        var leftChild = currentNode.left;

        leftChild.parent = parentOfCurrent;
        parentOfCurrent.right = leftChild;
        current.left = parentOfCurrent;
        current.parent = parentOfCurrent.parent;
        parentOfCurrent.parent = current;

        currentNode = current;
        if (currentNode.parent == null) {
          root = currentNode;
          break;
        }
      }
    } else if (currentNode.data.type.priority > node.data.type.priority) {
      var parentOfCurrent = currentNode.parent;
      node.parent = parentOfCurrent;
      node.left = currentNode;

      parentOfCurrent.right = node;
      currentNode.parent = node;
      currentNode = node;
      while (currentNode.parent.data.type.priority >=
          currentNode.data.type.priority) {
        currentNode.parent.right = currentNode.left;
        currentNode.left.parent = currentNode.parent;
        currentNode.left = currentNode.parent;
        if (currentNode.parent.parent != null) {
          currentNode.parent.parent.right = currentNode;
        }
        currentNode.parent = currentNode.parent.parent;
        if (currentNode.parent == null) {
          root = currentNode;
          break;
        }
      }
    }
  }

  bool _isOperator(Token token) {
    if (token == null) return false;
    return token.type != TokenType.NUMBER && token.type != TokenType.DECIMAL;
  }

  double _calculate(Node node) {
    if (node == null || node.data == null) return 0;
    if (_isOperator(node.data) && (node.left == null || node.right == null))
      throw Exception("Bad formating");
    if (_isOperator(node.data)) {
      var left = _calculate(node.left);
      var right = _calculate(node.right);
      return _applyOperand(left, right, node.data);
    }
    return double.parse(node.data.data);
  }

  double _applyOperand(double left, double right, Token token) {
    left = left.abs();
    right = right.abs();
    if (token.type == TokenType.PLUS) {
      return left + right;
    } else if (token.type == TokenType.MINUS) {
      return left - right;
    } else if (token.type == TokenType.MULTIPLY) {
      return left * right;
    } else if (token.type == TokenType.DIVIDE) {
      return left / right;
    }
    return null;
  }
}
