import 'package:conekta_component/src/models/card_model.dart';
import 'package:conekta_component/src/services/payment_service.dart';

class MockPaymentService extends PaymentService {
  MockPaymentService({required super.apiKey});

  @override
  Future<Map<String, dynamic>> sendPayment(
      CardModel card, String locale) async {
    return {
      'id': 'tok_12345',
      'status': 'success',
    };
  }
}
