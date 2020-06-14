import 'package:flutter/material.dart';
import 'calc/calc.dart';

class MyCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCalculatorState();
}

class MyCalculatorState extends State<MyCalculator> {
  String formula = "";
  String result = "0";

  String currentNumber = "";
  String operand = "";

  Calc _calculator = Calc();

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'CLEAR') {
        result = "0";
        formula = "";
        _calculator.clear();
        currentNumber = "";
        operand = "";
        return;
      }

      formula += buttonText;
      if (RegExp(r'[0-9]').hasMatch(buttonText)) {
        currentNumber += buttonText;
        result =
            Calc.calculateTemp(_calculator, operand, currentNumber).toString();
      } else if (buttonText == '=') {
        if (currentNumber.isEmpty || formula.isEmpty) {}
        _calculator.addElement(operand);
        _calculator.addElement(currentNumber);
        result = _calculator.calculate().toString();
        currentNumber = "";
        operand = "";
        formula = "";
        _calculator.clear();
      } else {
        try {
          _calculator.addElement(operand);
          _calculator.addElement(currentNumber);
          currentNumber = "";
          operand = buttonText;
          result = _calculator.calculate().toString();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  Expanded buildButton(String buttonText) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(30.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 22.0,
              horizontal: 12.0,
            ),
            child: Text(
              formula,
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 22.0,
              horizontal: 12.0,
            ),
            child: Text(
              result,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(children: <Widget>[
            Row(children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/")
            ]),
            Row(children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("x")
            ]),
            Row(children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-")
            ]),
            Row(children: <Widget>[
              buildButton("."),
              buildButton("0"),
              buildButton("00"),
              buildButton("+")
            ]),
            Row(children: <Widget>[
              buildButton("CLEAR"),
              buildButton("="),
            ]),
          ])
        ],
      )),
    );
  }
}
