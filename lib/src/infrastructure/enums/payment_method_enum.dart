enum PaymentMethodEnum {
  masterCard,
  bkash,
  rocket;
}

extension PaymentMEExt on PaymentMethodEnum {
  String get image {
    return switch (this) {
      PaymentMethodEnum.masterCard => "assets/images/master_card.png",
      PaymentMethodEnum.bkash => "assets/images/bkash.png",
      PaymentMethodEnum.rocket => "assets/images/rocket.png",
    };
  }

  String get title {
    return switch (this) {
      PaymentMethodEnum.masterCard => "Master card",
      PaymentMethodEnum.bkash => "Bkash",
      PaymentMethodEnum.rocket => "Rocket",
    };
  }
}
