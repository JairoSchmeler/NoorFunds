import 'package:encrypt/encrypt.dart' as encrypt;

/// Utility class for encrypting and decrypting sensitive text.
class EncryptionUtil {
  static final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  /// Encrypt [text] to a Base64 string.
  static String encryptText(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  /// Decrypt a previously encrypted Base64 [text].
  static String decryptText(String text) {
    return _encrypter.decrypt64(text, iv: _iv);
  }
}
