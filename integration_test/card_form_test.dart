import 'dart:io';

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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Android emulator reaches the host machine via 10.0.2.2.
  final mockoonHost =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';

  testWidgets('CardForm submits against Mockoon and returns success',
      (tester) async {
    bool submitted = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: CardForm(
            paymentService:
                PaymentService(apiKey: 'key_xxx', host: mockoonHost),
            onSubmitted: (result) {
              submitted = result is Success<Map<String, dynamic>>;
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(CardNameField), 'Juan Pérez');
    await tester.enterText(find.byType(CardNumberField), '4242424242424242');
    await tester.enterText(find.byType(CardExpiryFields), '12/30');
    await tester.enterText(find.byType(CardCVVField), '123');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(const Duration(seconds: 30));

    expect(submitted, isTrue);
  });
}
