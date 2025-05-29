// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get cardNameLabel => 'Nombre en la tarjeta';

  @override
  String get cardNameHint => 'Nombre como aparece en la tarjeta';

  @override
  String get cardNumberLabel => 'Número de tarjeta';

  @override
  String get cardNumberHint => '0000 0000 0000 0000';

  @override
  String get expiryDateLabel => 'Expiración';

  @override
  String get expiryDateHint => 'MM/AA';

  @override
  String get cvvLabel => 'CVV';

  @override
  String get cvvHint => 'CVV';

  @override
  String get submitButton => 'Continuar';

  @override
  String get invalidCVV => 'CVV inválido';

  @override
  String get numbersOnly => 'Solo números';

  @override
  String get errornameCardNoValid => 'Nombre de tarjeta inválido';

  @override
  String get paySafeWithConekta => 'Paga segura con';

  @override
  String get errorNumberNoValid => 'Número no valido';

  @override
  String get expiryDateRequired => 'Fecha requerida';

  @override
  String get expiryDateFormatInvalid => 'Formato inválido (MM/AA)';

  @override
  String get expiryDateMonthInvalid => 'Mes inválido';

  @override
  String get expiryDateYearInvalid => 'Año inválido';

  @override
  String get expiryDateYearExpired => 'Año expirado';

  @override
  String get expiryDateExpired => 'Fecha expirada';
}
