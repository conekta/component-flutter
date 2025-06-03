import 'package:conekta_component/card_input_flutter.dart';
import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore_for_file: type=lint

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CreditCardFormScreen(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}

class CreditCardFormScreen extends StatelessWidget {
  const CreditCardFormScreen({super.key});

  void _onSubmitted(Result<Map<String, dynamic>> result) {
    if (result is Success<Map<String, dynamic>>) {
      print("ok: ${result.value}");
    } else if (result is Failure<Map<String, dynamic>>) {
      print("Error: ${result.exception}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentService = PaymentService(
      apiKey: 'key_xxxx',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('my app')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CardForm(
          onSubmitted: _onSubmitted,
          paymentService: paymentService,
          locale: const Locale('es'),
        ),
      ),
    );
  }
}
