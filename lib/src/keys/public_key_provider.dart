import 'package:encrypt/encrypt.dart' as encrypt_pkg;
import 'package:pointycastle/asymmetric/api.dart';

import 'public_key_data.dart';

class PublicKeyProvider {
  static final PublicKeyProvider _instance = PublicKeyProvider._internal();
  late final RSAPublicKey publicKey;

  factory PublicKeyProvider() => _instance;

  PublicKeyProvider._internal() {
    final parser = encrypt_pkg.RSAKeyParser();
    publicKey = parser.parse(publicKeyPem) as RSAPublicKey;
  }
}
