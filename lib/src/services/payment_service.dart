import 'package:conekta_component/src/version.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/card_model.dart';

class PaymentService {
  final http.Client client;

  /// Public API key used to authenticate with Conekta.
  ///
  /// For more information, see the [Conekta API keys documentation](https://developers.conekta.com/docs/api-keys-producci%C3%B3n#llave-p%C3%BAblica).
  final String apiKey;
  final String host;
  static const String _defaultHost = 'https://api.conekta.io';

  PaymentService({
    required this.apiKey,
    this.host = _defaultHost,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<Map<String, dynamic>> sendPayment(CardModel card, String locale) async {
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
          'number': card.cardNumber,
          'name': card.name,
          'cvc': card.cvv,
          'exp_month': card.expiryMonth,
          'exp_year': card.expiryYear,
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
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException({required this.statusCode, required this.message});

  @override
  String toString() => 'HttpException: $statusCode - $message';
}
