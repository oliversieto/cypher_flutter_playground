import 'dart:math';

class CypherModel {
  final _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final _onlyLetterRegex = RegExp(r'[A-Z]');
  final _letterToEncryption = 'A';
  final _numberToEncryption = 26;

  String generateKey(int lengthOfKey) {
    return String.fromCharCodes(Iterable.generate(
      lengthOfKey,
      (_) => _chars.codeUnitAt(Random.secure().nextInt(_chars.length)),
    ));
  }

  String encode(String wordToEncrypt, String key) {
    if (_hasNotSameLength(wordToEncrypt, key)) {
      throw const FormatException(
          'wordToEncrypt should have same length with key');
    }

    if (_isNotUpperCase(wordToEncrypt)) {
      throw const FormatException(
          'wordToEncrypt should have only upper case letters');
    }

    if (_isNotUpperCase(key)) {
      throw const FormatException('key should have only upper case letters');
    }

    var encryptedWord = '';

    for (var index = 0; index < wordToEncrypt.length; index++) {
      if (_isLetter(wordToEncrypt[index])) {
        final calculationOfCharCodes =
            _calculationOfCharCodesToEncrypt(wordToEncrypt, key, index);
        encryptedWord +=
            _getLetterFromCharCodeCalculation(calculationOfCharCodes);
      } else {
        encryptedWord += wordToEncrypt[index];
      }
    }

    return encryptedWord;
  }

  String decode(String wordToDecrypt, String key) {
    if (_hasNotSameLength(wordToDecrypt, key)) {
      throw const FormatException(
          'wordToDecrypt should have same length with key');
    }

    if (_isNotUpperCase(wordToDecrypt)) {
      throw const FormatException(
          'wordToDecrypt should have only upper case letters');
    }

    if (_isNotUpperCase(key)) {
      throw const FormatException('key should have only upper case letters');
    }

    var decryptedWord = '';

    for (var index = 0; index < wordToDecrypt.length; index++) {
      if (_isLetter(wordToDecrypt[index])) {
        final calculationOfCharCodes =
            _calculationOfCharCodesToDecrypt(wordToDecrypt, key, index);
        decryptedWord +=
            _getLetterFromCharCodeCalculation(calculationOfCharCodes);
      } else {
        decryptedWord += wordToDecrypt[index];
      }
    }

    return decryptedWord;
  }

  bool _isLetter(String letter) {
    return _onlyLetterRegex.hasMatch(letter);
  }

  bool _isNotUpperCase(String word) {
    return word != word.toUpperCase();
  }

  bool _hasNotSameLength(String word, String wordToCompare) {
    return word.length != wordToCompare.length;
  }

  String _getLetterFromCharCodeCalculation(int sum) {
    final modOfSumOfCharCodes = sum % _numberToEncryption;
    final charCodeResult =
        modOfSumOfCharCodes + _letterToEncryption.codeUnitAt(0);
    return String.fromCharCode(charCodeResult);
  }

  int _calculationOfCharCodesToEncrypt(String word, String key, int index) {
    return word.codeUnitAt(index) + key.codeUnitAt(index);
  }

  int _calculationOfCharCodesToDecrypt(String word, String key, int index) {
    var sum = word.codeUnitAt(index) - key.codeUnitAt(index);
    return sum + _numberToEncryption;
  }
}
