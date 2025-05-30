import 'package:conekta_component/l10n/app_localizations.dart';
import 'package:conekta_component/src/services/result.dart';
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
  final void Function(Result<Map<String, dynamic>> result)? onSubmitted;
  final PaymentService paymentService;
  final Locale locale;
  final ThemeData? themeData;
  const CardForm(
      {super.key,
      this.onSubmitted,
      required this.paymentService,
      this.locale = const Locale('es'),
      this.themeData});

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  late ThemeData _effectiveTheme;

  @override
  void initState() {
    super.initState();
    _effectiveTheme = widget.themeData ?? cardInputTheme;
  }

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
        cleanFields();
        widget.onSubmitted?.call(Success(result));
      } on Exception catch (  e ) {
        widget.onSubmitted?.call(Failure(e));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  cleanFields(){
    cardNumberController.clear();
    nameController.clear();
    expiryDateController.clear();
    cvvController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: widget.locale,
        child: Builder(builder: (localizedContext) {
          return Theme(
            data: _effectiveTheme,
            child: Builder(builder: (themedContext) {
              return Form(
                key: _formKey,
                onChanged: _onFormChanged,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(themedContext).colorScheme.surface,
                      border: Border.all(
                        color: Theme.of(themedContext).colorScheme.shadow,
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
                                  .cardNameHint),
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
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: SvgPicture.network(
                                    'https://assets.conekta.com/checkout/img/logos/visa.svg',
                                    height: 26,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: SvgPicture.network(
                                    'https://assets.conekta.com/checkout/img/logos/amex.svg',
                                    height: 26,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: SvgPicture.network(
                                    'https://assets.conekta.com/checkout/img/logos/master-card.svg',
                                    height: 26,
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
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: SvgPicture.network(
                                              'https://assets.conekta.com/cpanel/statics/assets/img/icons/cvv-icon-32x32.svg',
                                              height: 36,
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
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(themedContext).primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: Theme.of(themedContext)
                                            .colorScheme
                                            .onPrimary))
                                : Text(
                                    AppLocalizations.of(localizedContext)!
                                        .submitButton,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(themedContext)
                                            .colorScheme
                                            .onPrimary)),
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
