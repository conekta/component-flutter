import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardExpiryFields extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;

  const CardExpiryFields({
    super.key,
    required this.controller,
    this.decoration,
  });

  String? _validateExpiryDate(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.expiryDateRequired;
    }

    final parts = value.split('/');
    if (parts.length != 2) {
      return AppLocalizations.of(context)!.expiryDateFormatInvalid;
    }

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || month < 1 || month > 12) {
      return AppLocalizations.of(context)!.expiryDateMonthInvalid;
    }

    if (year == null || year < 0 || year > 99) {
      return AppLocalizations.of(context)!.expiryDateYearInvalid;
    }

    final now = DateTime.now();
    final fullYear = 2000 + year;

    if (fullYear < now.year) {
      return AppLocalizations.of(context)!.expiryDateYearExpired;
    }

    if (fullYear == now.year && month < now.month) {
      return AppLocalizations.of(context)!.expiryDateExpired;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(5),
        ExpiryDateInputFormatter(),
      ],
      decoration: decoration,
      validator: (value) => _validateExpiryDate(context, value),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length > 4) {
      digits = digits.substring(0, 4);
    }

    String formatted = '';
    int cursorPosition = newValue.selection.baseOffset;

    if (digits.length >= 3) {
      formatted = '${digits.substring(0, 2)}/${digits.substring(2)}';
    } else if (digits.isNotEmpty && digits.length <= 2) {
      formatted = digits;
    }

    if (oldValue.text.endsWith('/') && !newValue.text.contains('/')) {
      cursorPosition -= 1;
    } else if (digits.length == 2 && oldValue.text.length == 1) {
      cursorPosition += 1;
    }

    if (digits.length >= 3) {
      cursorPosition = formatted.length;
    } else {
      cursorPosition = formatted.length;
    }

    cursorPosition = cursorPosition.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
