import 'package:conekta_component/card_input_flutter.dart';
import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:conekta_component/src/widgets/secure_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('es'), Locale('en')],
    home: Scaffold(body: child),
  );
}

void main() {
  final paymentService = PaymentService(apiKey: 'key_test');

  group('CardForm config', () {
    testWidgets('hides SecurePaymentSection when showSecurePaymentBadge is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
        CardForm(
          paymentService: paymentService,
          config: const CardFormConfig(showSecurePaymentBadge: false),
        ),
      ));

      expect(find.byType(SecurePaymentSection), findsNothing);
    });

    testWidgets('submit button uses localized text by default (es)',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
        CardForm(paymentService: paymentService),
      ));

      expect(find.widgetWithText(ElevatedButton, 'Continuar'), findsOneWidget);
    });

    testWidgets('submit button uses localized text when locale is en',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
        CardForm(
          paymentService: paymentService,
          locale: const Locale('en'),
        ),
      ));

      expect(find.widgetWithText(ElevatedButton, 'Continue'), findsOneWidget);
    });

    testWidgets('submit button text is overridden by submitButtonText',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
        CardForm(
          paymentService: paymentService,
          config: const CardFormConfig(submitButtonText: 'Pagar ahora'),
        ),
      ));

      expect(find.widgetWithText(ElevatedButton, 'Pagar ahora'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Continuar'), findsNothing);
    });

    testWidgets('config flags combine: hidden badge + custom text',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
        CardForm(
          paymentService: paymentService,
          config: const CardFormConfig(
            showSecurePaymentBadge: false,
            submitButtonText: 'Go',
          ),
        ),
      ));

      expect(find.byType(SecurePaymentSection), findsNothing);
      expect(find.widgetWithText(ElevatedButton, 'Go'), findsOneWidget);
    });
  });

  group('CardFormConfig defaults', () {
    test('showSecurePaymentBadge defaults to true', () {
      const config = CardFormConfig();
      expect(config.showSecurePaymentBadge, isTrue);
    });

    test('submitButtonText defaults to null', () {
      const config = CardFormConfig();
      expect(config.submitButtonText, isNull);
    });
  });
}
