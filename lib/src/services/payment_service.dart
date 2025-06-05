import 'dart:convert';

import 'package:conekta_component/src/version.dart';
import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;

import '../keys/public_key_provider.dart';
import '../models/card_model.dart';

class PaymentService {
  final http.Client client;

  /// Public API key used to authenticate with Conekta.
  ///
  /// For more information, see the [Conekta API keys documentation](https://developers.conekta.com/docs/api-keys-producci%C3%B3n#llave-p%C3%BAblica).
  final String apiKey;

  /// The base URL for the Conekta API.
  final String host;

  /// The default base URL for the Conekta API
  static const String _defaultHost = 'https://api.conekta.io';

  PaymentService({
    required this.apiKey,
    this.host = _defaultHost,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<Map<String, dynamic>> sendPayment(
      CardModel card, String locale) async {
    final url = Uri.parse('$host/tokens');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/vnd.conekta-v2.2.0+json',
        'Accept-Language': locale,
        'X-Tokenization-Source': 'flutter',
        'publisher': 'conekta',
        'origin': 'flutter sdk',
        'conekta-client-user-agent': jsonEncode({
          'agent': 'Conekta ActiveMerchantBindings',
          'lang': 'flutter',
          'publisher': 'conekta',
          'bindings_version': sdkVersion,
        })
      },
      body: jsonEncode({
        'card': {
          'number': encryptCardField(card.cardNumber),
          'name': encryptCardField(card.name),
          'cvc': encryptCardField(card.cvv),
          'exp_month': encryptCardField(card.expiryMonth),
          'exp_year': encryptCardField(card.expiryYear),
        }
      }),
    );

    if (response.statusCode < 300) {
      return jsonDecode(response.body);
    }
    throw HttpException(
      statusCode: response.statusCode,
      message: response.body,
    );
  }

  /// encryptCardField encrypts a card field using the public key.
  String encryptCardField(String plainText) {
    final publicKey = PublicKeyProvider().publicKey;
    final encrypter = Encrypter(RSA(
      publicKey: publicKey,
      encoding: RSAEncoding.PKCS1,
    ));
    return encrypter.encrypt(plainText).base64;
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException({required this.statusCode, required this.message});

  @override
  String toString() => 'HttpException: $statusCode - $message';
}
