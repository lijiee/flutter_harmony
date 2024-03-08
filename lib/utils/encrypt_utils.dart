import 'package:basic_utils/basic_utils.dart';
import 'package:encrypt/encrypt.dart';
class EncryptUtils {
  static String encryptRSA(String value, String rasPublicKey) {
    var pem =
        '-----BEGIN RSA PUBLIC KEY-----\n$rasPublicKey\n-----END RSA PUBLIC KEY-----';
    RSAPublicKey publicKey = CryptoUtils.rsaPublicKeyFromPem(pem);
    final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: null));
    String encryptedBase64 = encrypter.encrypt(value).base64;
    return encryptedBase64;
  }

  static String encryptAES(String value, {String publicKey = "whrenhekuaij2016"}) {
    final key = Key.fromUtf8(publicKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
    final encrypted = encrypter.encrypt(value, iv: iv);
    String encryptedBase64 = encrypted.base64;
    String dec = decryptAES(encryptedBase64);
    return encryptedBase64;
  }
  static String decryptAES(String value, {String publicKey = "whrenhekuaij2016"}) {
    final key = Key.fromUtf8(publicKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key,mode: AESMode.ecb));
    final decrypted = encrypter.decrypt64(value, iv: iv);
    return decrypted;
  }


}
