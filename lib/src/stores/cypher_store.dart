import 'package:flutter/widgets.dart';

import '../models/cypher_model.dart';

class CypherStore extends ChangeNotifier {
  final cypherModel = CypherModel();
  String wordToEncrypt = '';
  String keyToEncrypt = '';
  String wordToDecrypt = '';
  String keyToDecrypt = '';
  String? _encryptedResult;
  String? _decryptedResult;

  void setWordToEncrypt(String value) => wordToEncrypt = value;

  void setWordToDecrypt(String value) => wordToDecrypt = value;

  void setKeyToDecrypt(String value) => keyToDecrypt = value;

  String? get encryptedResult => _encryptedResult;

  String? get decryptedResult => _decryptedResult;

  void encode() {
    try {
      keyToEncrypt = cypherModel.generateKey(wordToEncrypt.length);
      final encryptedWord = cypherModel.encode(wordToEncrypt, keyToEncrypt);
      _encryptedResult = 'Encrypted: $encryptedWord - Key: $keyToEncrypt';
    } on FormatException catch (e) {
      _encryptedResult = e.message;
    } finally {
      notifyListeners();
    }
  }

  void decode() {
    try {
      final decryptedWord = cypherModel.decode(wordToDecrypt, keyToDecrypt);
      _decryptedResult = 'Decrypted: $decryptedWord';
    } on FormatException catch (e) {
      _decryptedResult = e.message;
    } finally {
      notifyListeners();
    }
  }
}
