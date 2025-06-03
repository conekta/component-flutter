import 'package:conekta_component/card_input_flutter.dart';
import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:conekta_component/src/fields/card_cvv_field.dart';
import 'package:conekta_component/src/fields/card_expiry_fields.dart';
import 'package:conekta_component/src/fields/card_name_field.dart';
import 'package:conekta_component/src/fields/card_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'mocks/mock_payment_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CardForm submits and returns success', (tester) async {
    bool submitted = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: CardForm(
            paymentService: MockPaymentService(apiKey: "key_xxx"),
            onSubmitted: (result) {
              submitted = result is Success<Map<String, dynamic>>;
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(CardNameField), 'Juan Pérez');
    await tester.enterText(find.byType(CardNumberField), '4242424242424242');
    await tester.enterText(find.byType(CardExpiryFields), '12/25');
    await tester.enterText(find.byType(CardCVVField), '123');

    await tester.tap(find.byType(ElevatedButton), warnIfMissed: true);
    await tester.pumpAndSettle();

    expect(submitted, isTrue);
  });
}
