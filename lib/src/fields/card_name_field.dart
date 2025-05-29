import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CardNameField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;

  const CardNameField({required this.controller, this.decoration, super.key});
  String? _validateCardName(BuildContext context, String? value) {
    final name = value?.replaceAll(' ', '');
    if (name == null || name.isEmpty) {
      return AppLocalizations.of(context)!.errornameCardNoValid;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration,
      validator: (value) => _validateCardName(context, value),
    );
  }
}
