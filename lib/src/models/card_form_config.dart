/// Configuration options for customizing [CardForm]'s appearance and copy.
class CardFormConfig {
  /// When `true`, hides the "Secure payment with Conekta" logo/badge shown
  /// below the form. Defaults to `false` (badge visible).
  final bool hideLogo;

  /// Overrides the text displayed on the submit button. When `null`, the
  /// button falls back to the localized default ("Pagar" / "Pay").
  final String? submitButtonText;

  const CardFormConfig({
    this.hideLogo = false,
    this.submitButtonText,
  });
}
