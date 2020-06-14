class TokenType {
  final _value;
  final _name;
  final int _priority;

  const TokenType._internal(this._value, this._name, this._priority);

  String get value => _value;
  int get priority => _priority;
  String get name => _name;

  toString() => 'Token.$_value';

  static const NUMBER = const TokenType._internal(r"\d+", 'NUMBER', 1);
  static const DECIMAL = const TokenType._internal(r"\d+\.\d+", 'DECIMAL', 1);
  static const PLUS = const TokenType._internal(r"[+]", 'PLUS', 2);
  static const MINUS = const TokenType._internal(r'\-', 'MINUS', 2);
  static const MULTIPLY = const TokenType._internal(r'[x*]', 'MULTIPLY', 3);
  static const DIVIDE = const TokenType._internal(r'[/]', 'DIVIDE', 4);
  static const EQUALS = const TokenType._internal(r'\=', 'EQUALS', 1);
  static const EXPONENT = const TokenType._internal(r'[^]', 'EXPONENT', 5);
  static const LEFT_PAREN = const TokenType._internal(r'\(', 'LEFT_PAREN', 5);
  static const RIGHT_PAREN = const TokenType._internal(r'\)', 'RIGHT_PAREN', 5);

  static all() {
    return [
      DECIMAL,
      NUMBER,
      PLUS,
      MINUS,
      MULTIPLY,
      DIVIDE,
      EQUALS,
      EXPONENT,
      LEFT_PAREN,
      RIGHT_PAREN,
    ];
  }
}
