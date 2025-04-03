import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/route_config.dart';

import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/add_payment_button.dart';
import 'widgets/payment_card_view.dart';
import 'widgets/payment_confirm_dialog.dart';
import 'widgets/saved_card_view.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.total,
  });
  final double total;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethodEnum selectedMethod = PaymentMethodEnum.masterCard;

  List<UserPaymentMethod> savedItems = [
    UserPaymentMethod.ui,
    UserPaymentMethod.ui,
    UserPaymentMethod.ui,
  ];

  UserPaymentMethod selectedUserAccount = UserPaymentMethod.ui;

  double total = 20;

  @override
  Widget build(BuildContext context) {
    return BackgroundView.two(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    AppBar(
                      title: const LabelView(label: "Payment method"),
                      centerTitle: true,
                      iconTheme: const IconThemeData(color: Colors.black),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: PaymentMethodEnum.values
                          .map(
                            (e) => PaymentCardView(
                              isSelected: selectedMethod == e,
                              type: e,
                              onTap: () {
                                selectedMethod = e;
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    const AddPaymentButton(),
                    const SizedBox(height: 24),
                    for (final um in savedItems) //
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: UserSavedItemView(
                          info: um,
                          isSelected: selectedUserAccount == um,
                          onTap: () {
                            selectedUserAccount = um;
                            setState(() {});
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:\$${total.toStringAsFixed(1)}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    AppButton(
                      label: "Pay Now",
                      onTap: () async {
                        await PaymentConfirmDialog.show(context);
                        if (context.mounted) context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
