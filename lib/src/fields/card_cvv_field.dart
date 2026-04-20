import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:conekta_component/l10n/app_localizations.dart';

class CardCVVField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;

  const CardCVVField({super.key, required this.controller, this.decoration});

  // Validates the CVV. It must be 3 or 4 digits.
  // Returns an error message if validation fails, otherwise returns null.
  String? _validateCVV(BuildContext context, String? value) {
    if (value == null || value.length < 3 || value.length > 4) {
      return AppLocalizations.of(context)!.invalidCVV;
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return AppLocalizations.of(context)!.numbersOnly;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration ??
          const InputDecoration(
            labelText: 'CVV',
            isDense: true,
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      validator: (value) => _validateCVV(context, value),
    );
  }
}
