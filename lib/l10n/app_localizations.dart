import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @cardNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Cardholder name'**
  String get cardNameLabel;

  /// No description provided for @cardNameHint.
  ///
  /// In en, this message translates to:
  /// **'Name as it appears on the card'**
  String get cardNameHint;

  /// No description provided for @cardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get cardNumberLabel;

  /// No description provided for @cardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'0000 0000 0000 0000'**
  String get cardNumberHint;

  /// No description provided for @expiryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get expiryDateLabel;

  /// No description provided for @expiryDateHint.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get expiryDateHint;

  /// No description provided for @cvvLabel.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvvLabel;

  /// No description provided for @cvvHint.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvvHint;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get submitButton;

  /// No description provided for @invalidCVV.
  ///
  /// In en, this message translates to:
  /// **'Invalid CVV'**
  String get invalidCVV;

  /// No description provided for @numbersOnly.
  ///
  /// In en, this message translates to:
  /// **'Numbers only'**
  String get numbersOnly;

  /// No description provided for @errornameCardNoValid.
  ///
  /// In en, this message translates to:
  /// **'Invalid card name'**
  String get errornameCardNoValid;

  /// No description provided for @paySafeWithConekta.
  ///
  /// In en, this message translates to:
  /// **'Pay Secure with'**
  String get paySafeWithConekta;

  /// No description provided for @errorNumberNoValid.
  ///
  /// In en, this message translates to:
  /// **'Number no valid'**
  String get errorNumberNoValid;

  /// No description provided for @expiryDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Date required'**
  String get expiryDateRequired;

  /// No description provided for @expiryDateFormatInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid format (MM/YY)'**
  String get expiryDateFormatInvalid;

  /// No description provided for @expiryDateMonthInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid month'**
  String get expiryDateMonthInvalid;

  /// No description provided for @expiryDateYearInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid year'**
  String get expiryDateYearInvalid;

  /// No description provided for @expiryDateYearExpired.
  ///
  /// In en, this message translates to:
  /// **'Year expired'**
  String get expiryDateYearExpired;

  /// No description provided for @expiryDateExpired.
  ///
  /// In en, this message translates to:
  /// **'Date expired'**
  String get expiryDateExpired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
