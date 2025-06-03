import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardNumberField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;

  const CardNumberField({
    super.key,
    required this.controller,
    this.decoration,
  });

  String? _validateCardNumber(BuildContext context, String? value) {
    final number = value?.replaceAll(' ', '');
    if (number == null ||
        number.isEmpty ||
        number.length < 13 ||
        number.length > 19) {
      return AppLocalizations.of(context)!.errorNumberNoValid;
    }
    if (!RegExp(r'^\d+$').hasMatch(number)) {
      return AppLocalizations.of(context)!.numbersOnly;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(19),
        CardNumberInputFormatter(),
      ],
      validator: (value) => _validateCardNumber(context, value),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length > 19) {
      digits = digits.substring(0, 19);
    }
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if ((i + 1) % 4 == 0 && i + 1 != digits.length) {
        buffer.write(' ');
      }
    }
    final formatted = buffer.toString();
    int cursorPosition = formatted.length;
    // Ajustar la posición del cursor si el usuario borra o inserta en medio
    if (newValue.selection.baseOffset < formatted.length) {
      int nonSpaceCount = 0;
      for (int i = 0; i < formatted.length; i++) {
        if (formatted[i] != ' ') {
          nonSpaceCount++;
        }
        if (nonSpaceCount == newValue.selection.baseOffset) {
          cursorPosition = i + 1;
          break;
        }
      }
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
