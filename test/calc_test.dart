// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:test_api/test_api.dart';

import 'package:calculator/calc/calc.dart';

void main() {
  Calc calculator = Calc();

  group("Calculator parser", () {
    test(".calculate() -> 1+2+4 => 7", () {
      double result = 1 + 2 + 4.0;
      var items = ['1', '+', '2', '+', '4'];

      for (var i in items) {
        calculator.addElement(i);
      }

      expect(calculator.calculate(), equals(result));
    });

    test(".calculate() -> 5 * 8 / 99 - 3 => -2.59", () {
      double result = 5 * 8 / 99 - 3;
      var items = ['5', '*', '8', '/', '99', '-', '3'];

      for (var i in items) {
        calculator.addElement(i);
      }

      expect(calculator.calculate(), equals(result));
      printOnFailure(
          calculator.calculate().toString() + " " + result.toString());
    });

    test(".calculate() -> 5 - 8 / 99 - 3 => 1.9191", () {
      double result = 5 - 8 / 99 - 3;
      var items = ['5', '-', '8', '/', '99', '-', '3'];

      for (var i in items) {
        calculator.addElement(i);
      }
      print(calculator.root.toString());
      expect(calculator.calculate(), equals(result));
      printOnFailure(calculator.tokens.toString());
    });

    test(".calculate() -> 4 + 1 - 99 => -94", () {
      double result = 4 + 1 - 99.0;
      var items = ['4', '+', '1', '-', '99'];

      for (var i in items) {
        calculator.addElement(i);
      }

      print(calculator.root.toString());

      expect(calculator.calculate(), equals(result));
      printOnFailure(calculator.tokens.toString());
    });

    test(".calculate() -> 4 + 1 * 99 / 3 * 8 => 268", () {
      double result = 4.0 + 1 * 99 / 3 * 8;
      var items = ['4', '+', '1', '*', '99', '/', '3', '*', '8'];

      for (var i in items) {
        calculator.addElement(i);
      }

      print(calculator.tokens.toString());
      print(calculator.root.toString());

      expect(calculator.calculate(), equals(result));
      printOnFailure(calculator.tokens.toString());
    });

    test(".calculate() -> 4 * 1 * 99 / 3 * 8 => 1056", () {
      double result = 4.0 * 1 * 99 / 3 * 8;
      var items = ['4', '*', '1', '*', '99', '/', '3', '*', '8'];

      for (var i in items) {
        calculator.addElement(i);
      }

      print(calculator.tokens.toString());
      print(calculator.root.toString());

      expect(calculator.calculate(), equals(result));
      printOnFailure(calculator.tokens.toString());
    });

    test(".calculate() -> 5 + 3 * 99.8 / 7 * 9 - 78 => 311.94", () {
      double result = 5 + 3 * 99.8 / 7 * 9 - 78;
      var items = ['5', '+', '3', '*', '99.8', '/', '7', '*', '9', '-', '78'];

      for (var i in items) {
        calculator.addElement(i);
      }

      print(calculator.tokens.toString());
      print(calculator.root.toString());

      expect(calculator.calculate().toStringAsFixed(8),
          equals(result.toStringAsFixed(8)));
      printOnFailure(calculator.tokens.toString());
    });

    tearDown(() => calculator.clear());
  });
}
