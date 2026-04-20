import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:conekta_component/src/widgets/secure_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String title = 'PAGA SEGURA CON';
  final Widget localLogo = SvgPicture.asset(
    'test/assets/conekta-logo-blue-full.svg',
    height: 20.0,
  );
  group('SecurePaymentSection Widget Tests', () {
    testWidgets('renders all expected elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', ''),
          ],
          home: Scaffold(
            body: SecurePaymentSection(logo: localLogo),
          ),
        ),
      );
      expect(find.text(title), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('Text style is labelSmall', (WidgetTester tester) async {
      final ThemeData testTheme = ThemeData(
        textTheme: const TextTheme(
          labelSmall: TextStyle(fontSize: 10, color: Colors.blue),
        ),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.purple, shadow: Colors.grey),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', ''),
          ],
          home: Scaffold(
            body: SecurePaymentSection(logo: localLogo),
          ),
        ),
      );
      final Text textWidget = tester.widget(find.text(title));
      expect(
          textWidget.style?.fontSize, testTheme.textTheme.labelSmall?.fontSize);
      expect(textWidget.style?.color, testTheme.textTheme.labelSmall?.color);
    });

    testWidgets('Divider has correct color from theme',
        (WidgetTester tester) async {
      final testTheme = ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.green, shadow: Colors.red),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', ''),
          ],
          home: Scaffold(
            body: SecurePaymentSection(logo: localLogo),
          ),
        ),
      );

      final Divider dividerWidget = tester.widget(find.byType(Divider));
      expect(dividerWidget.color, testTheme.colorScheme.shadow);
    });
  });
}
