import 'package:cypher_flutter_playground/src/models/cypher_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final CypherModel cypherModel;
  late final int lengthOfKey;
  late final String wordToEncrypt;
  late final String encryptedWord;
  late final String keyToEncrypt;

  group('CypherModel', () {
    setUpAll(() {
      cypherModel = CypherModel();
      lengthOfKey = 10;
      wordToEncrypt = 'BANANA';
      encryptedWord = 'DXILHY';
      keyToEncrypt = 'CXVLUY';
    });

    group('generateKey', () {
      test('should return a key with same length with text param', () {
        final key = cypherModel.generateKey(lengthOfKey);
        expect(key.length, lengthOfKey);
      });

      test('should return a key with only uppercase letters', () {
        final key = cypherModel.generateKey(lengthOfKey);
        expect(key.toUpperCase(), key);
      });

      test('should return key with only letters', () {
        final key = cypherModel.generateKey(lengthOfKey);
        final matcher = key.replaceAll(RegExp(r'[A-Z]'), '');
        expect(matcher, isEmpty);
      });
    });

    group('encode', () {
      test(
          'should throw an exception if key does not have same length with word to encrypt',
          () {
        var key = cypherModel.generateKey(wordToEncrypt.length);
        key = key.substring(1);
        expect(() => cypherModel.encode(wordToEncrypt, key),
            throwsA(isA<FormatException>()));
      });

      test(
          'should throw an exception if word to encrypt has lower case letters',
          () {
        var key = cypherModel.generateKey(wordToEncrypt.length);
        expect(() => cypherModel.encode(wordToEncrypt.toLowerCase(), key),
            throwsA(isA<FormatException>()));
      });

      test('should throw an exception if key has lower case letters', () {
        var key = cypherModel.generateKey(wordToEncrypt.length);
        expect(() => cypherModel.encode(wordToEncrypt, key.toLowerCase()),
            throwsA(isA<FormatException>()));
      });

      test('should return an encrypted word', () {
        var key = cypherModel.generateKey(wordToEncrypt.length);
        var encryptedWord = cypherModel.encode(wordToEncrypt, key);
        expect(encryptedWord, isNot(wordToEncrypt));
      });

      test('should return an encrypted word with static key', () {
        var encryptedWord = cypherModel.encode(wordToEncrypt, keyToEncrypt);
        expect(encryptedWord, encryptedWord);
      });

      test('should return an encrypted word with special chars', () {
        var encryptedWord = cypherModel.encode('BA?A9A', keyToEncrypt);
        expect(encryptedWord, 'DX?L9Y');
      });
    });

    group('decode', () {
      test(
          'should throw an exception if key does not have same length with word to encrypt',
          () {
        final key = keyToEncrypt.substring(1);
        expect(() => cypherModel.decode(encryptedWord, key),
            throwsA(isA<FormatException>()));
      });

      test(
          'should throw an exception if word to encrypt has lower case letters',
          () {
        expect(
            () => cypherModel.decode(encryptedWord.toLowerCase(), keyToEncrypt),
            throwsA(isA<FormatException>()));
      });

      test('should throw an exception if key has lower case letters', () {
        expect(
            () => cypherModel.decode(encryptedWord, keyToEncrypt.toLowerCase()),
            throwsA(isA<FormatException>()));
      });

      test('should return a decrypted word', () {
        var decryptedWord = cypherModel.decode(encryptedWord, keyToEncrypt);
        expect(decryptedWord, wordToEncrypt);
      });

      test('should return a decrypted word with special chars', () {
        var encryptedWord = cypherModel.decode('DX?L9Y', keyToEncrypt);
        expect(encryptedWord, 'BA?A9A');
      });
    });
  });
}
