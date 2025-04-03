import '../infrastructure.dart';

class UserPaymentMethod {
  const UserPaymentMethod({
    required this.type,
    required this.cardNo,
    required this.exp,
    required this.holderName,
    required this.cvv,
  });

  final PaymentMethodEnum type;
  final String cardNo;
  final DateTime exp;
  final String holderName;
  final String cvv;

  static UserPaymentMethod get ui => UserPaymentMethod(
        type: PaymentMethodEnum.masterCard,
        cardNo: "1234-2323-1233-1233",
        exp: DateTime(2222, 8),
        holderName: "John Ripper",
        cvv: "000",
      );
}
