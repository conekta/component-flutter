class CardModel {
  final String cardNumber;
  final String name;
  final String cvv;
  final String expiryMonth;
  final String expiryYear;

  CardModel({
    required this.cardNumber,
    required this.name,
    required this.cvv,
    required this.expiryMonth,
    required this.expiryYear,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber,
      'name': name,
      'cvv': cvv,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
    };
  }
}
