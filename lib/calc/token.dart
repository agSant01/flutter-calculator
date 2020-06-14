import 'token_type.dart';

class Token {
  TokenType type;
  String data;

  Token(this.data, this.type);

  @override
  String toString() {
    return type.name + '(' + data.toString() + ')';
  }
}
