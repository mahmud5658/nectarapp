import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import 'widgets/add_card_form.dart';
import '../../infrastructure/enums/payment_method_enum.dart';
import '../_common/_common.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({
    super.key,
    required this.type,
  });

  final PaymentMethodEnum type;

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundView(
      bubble: const [BackgroundBubble(alignment: Alignment(1.75, 0))],
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const LabelView(label: "Payment Details"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                const Radio(
                  value: true,
                  groupValue: true,
                  toggleable: false,
                  onChanged: null,
                  fillColor: WidgetStatePropertyAll(AppTheme.primary),
                ),
                SizedBox(
                  width: 72,
                  child: Image.asset(
                    widget.type.image,
                    fit: BoxFit.fitWidth,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            AddPaymentForm(),
          ],
        ),
      ),
    );
  }
}
