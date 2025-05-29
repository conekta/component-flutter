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
      ],
      validator: (value) => _validateCardNumber(context, value),
    );
  }
}
