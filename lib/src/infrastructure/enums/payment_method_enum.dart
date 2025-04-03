enum PaymentMethodEnum {
  masterCard,
  googlePay,
  paypal;
}

extension PaymentMEExt on PaymentMethodEnum {
  String get image {
    return switch (this) {
      PaymentMethodEnum.masterCard => "assets/images/master_card.png",
      PaymentMethodEnum.googlePay => "assets/images/google_pay.png",
      PaymentMethodEnum.paypal => "assets/images/paypal.png",
    };
  }

  String get title {
    return switch (this) {
      PaymentMethodEnum.masterCard => "Master card",
      PaymentMethodEnum.googlePay => "Google pay",
      PaymentMethodEnum.paypal => "PayPal",
    };
  }
}
