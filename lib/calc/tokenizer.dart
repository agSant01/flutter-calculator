import 'package:calculator/calc/token_type.dart';
import 'token.dart';

class Tokenizer {
  int _index = 0;
  String _input;

  List<Token> _tokenList = List<Token>();

  Tokenizer(String input) {
    this._input = input.replaceAll(RegExp(r' '), '');

    while (true) {
      var tok = _token();
      if (tok == null) break;
      _tokenList.add(tok);
    }
  }

  static List<Token> tokenize(String input) {
    return Tokenizer(input).getTokens();
  }

  List<Token> getTokens() {
    return _tokenList;
  }

  Token _token() {
    String token;
    TokenType typeToReturn;

    for (TokenType type in TokenType.all()) {
      token = _parseToken(type);
      typeToReturn = type;
      if (token != null) {
        break;
      }
    }
    if (token == null) return null;

    this._input = this._input.replaceFirst(token, '');
    return new Token(token, typeToReturn);
  }

  String _parseToken(TokenType type) {
    var exp = new RegExp(type.value);
    var match = exp.matchAsPrefix(this._input);

    if (match == null) return null;

    return match.group(0);
  }
}
