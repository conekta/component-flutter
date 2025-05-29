import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'models/card_model.dart';
import 'fields/card_cvv_field.dart';
import 'fields/card_expiry_fields.dart';
import 'fields/card_number_field.dart';
import 'fields/card_name_field.dart';
import 'services/payment_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'utils/theme.dart';
import 'widgets/secure_payment_section.dart';

class CardForm extends StatefulWidget {
  final void Function(Map<String, dynamic> result)? onSubmitted;
  final PaymentService paymentService;
  final Locale locale;
  const CardForm({
    super.key,
    this.onSubmitted,
    required this.paymentService,
    this.locale = const Locale('es'),
  });

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  final expiryDateController = TextEditingController();

  final cardNumberController = TextEditingController();
  final nameController = TextEditingController();
  final cvvController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    cardNumberController.dispose();
    nameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void _onFormChanged() {}
  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      final expiryDate = expiryDateController.text.split('/');
      final month = expiryDate.isNotEmpty ? expiryDate[0] : '';
      final year = expiryDate.length > 1 ? expiryDate[1] : '';
      final card = CardModel(
        cardNumber: cardNumberController.text,
        name: nameController.text,
        cvv: cvvController.text,
        expiryMonth: month,
        expiryYear: year,
      );

      try {
        final result = await widget.paymentService.sendPayment(card);
        cardNumberController.clear();
        nameController.clear();
        expiryDateController.clear();
        cvvController.clear();
        widget.onSubmitted?.call({
          'success': true,
          'data': result,
        });
      } catch (e) {
        widget.onSubmitted?.call({
          'success': false,
          'error': e,
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: widget.locale,
        child: Builder(builder: (localizedContext) {
          return Theme(
            data: cardInputTheme,
            child: Builder(builder: (themedContext) {
              return Form(
                key: _formKey,
                onChanged: _onFormChanged,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SecurePaymentSection(),
                        Text(
                            AppLocalizations.of(localizedContext)!
                                .cardNameLabel,
                            style:
                                Theme.of(themedContext).textTheme.titleSmall),
                        const SizedBox(height: 8),
                        CardNameField(
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(localizedContext)!
                                  .cardNameHint,
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              )),
                        ),
                        const SizedBox(height: 16),
                        Text(
                            AppLocalizations.of(localizedContext)!
                                .cardNumberLabel,
                            style:
                                Theme.of(themedContext).textTheme.titleSmall),
                        const SizedBox(height: 8),
                        CardNumberField(
                          controller: cardNumberController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(localizedContext)!
                                .cardNumberHint,
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: SvgPicture.network(
                                    'https://assets.conekta.com/checkout/img/logos/visa.svg',
                                    height: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: SvgPicture.network(
                                    'https://assets.conekta.com/checkout/img/logos/amex.svg',
                                    height: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: SvgPicture.network(
                                    'https://assets.conekta.com/checkout/img/logos/master-card.svg',
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(localizedContext)!
                                          .expiryDateLabel,
                                      style: Theme.of(themedContext)
                                          .textTheme
                                          .titleSmall),
                                  const SizedBox(height: 8),
                                  CardExpiryFields(
                                    controller: expiryDateController,
                                    decoration: InputDecoration(
                                      hintText:
                                          AppLocalizations.of(localizedContext)!
                                              .expiryDateHint,
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(localizedContext)!
                                          .cvvLabel,
                                      style: Theme.of(themedContext)
                                          .textTheme
                                          .titleSmall),
                                  const SizedBox(height: 8),
                                  CardCVVField(
                                    controller: cvvController,
                                    decoration: InputDecoration(
                                      hintText:
                                          AppLocalizations.of(localizedContext)!
                                              .cvvHint,
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: SvgPicture.network(
                                              'https://assets.conekta.com/cpanel/statics/assets/img/icons/cvv-icon-32x32.svg',
                                              height: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cardInputTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 3, color: Colors.white))
                                : Text(
                                    AppLocalizations.of(localizedContext)!
                                        .submitButton,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }));
  }
}
