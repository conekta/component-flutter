// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cardNameLabel => 'Cardholder name';

  @override
  String get cardNameHint => 'Name as it appears on the card';

  @override
  String get cardNumberLabel => 'Card number';

  @override
  String get cardNumberHint => '0000 0000 0000 0000';

  @override
  String get expiryDateLabel => 'Expiry';

  @override
  String get expiryDateHint => 'MM/YY';

  @override
  String get cvvLabel => 'CVV';

  @override
  String get cvvHint => 'CVV';

  @override
  String get submitButton => 'Continue';

  @override
  String get invalidCVV => 'Invalid CVV';

  @override
  String get numbersOnly => 'Numbers only';

  @override
  String get errornameCardNoValid => 'Invalid card name';

  @override
  String get paySafeWithConekta => 'Pay Secure with';

  @override
  String get errorNumberNoValid => 'Number no valid';

  @override
  String get expiryDateRequired => 'Date required';

  @override
  String get expiryDateFormatInvalid => 'Invalid format (MM/YY)';

  @override
  String get expiryDateMonthInvalid => 'Invalid month';

  @override
  String get expiryDateYearInvalid => 'Invalid year';

  @override
  String get expiryDateYearExpired => 'Year expired';

  @override
  String get expiryDateExpired => 'Date expired';
}
