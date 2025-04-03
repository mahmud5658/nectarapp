import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../app/route_config.dart';
import '../../_common/widgets/app_button.dart';
import 'payment_confirm_dialog.dart';

class AddPaymentForm extends StatefulWidget {
  const AddPaymentForm({super.key});

  @override
  State<AddPaymentForm> createState() => _AddPaymentFormState();
}

class _AddPaymentFormState extends State<AddPaymentForm> {
  final formKey = GlobalKey<FormState>();

  final cardNumber = TextEditingController();
  final expireYear = TextEditingController();
  final expireMonth = TextEditingController();
  final cardHolder = TextEditingController();
  final cvvController = TextEditingController();

  bool isChecked = false;

  String? emptyValidator(String? value) {
    if ((value ?? "").isEmpty) {
      return "can't be empty";
    }
    return null;
  }

  void onPaymentProceed() async {
    bool isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm == false) return;
    await PaymentConfirmDialog.show(context);
    context.go(AppRoute.home);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FromTextField(
            label: "Card Number",
            hintText: "*" * 12,
            controller: cardNumber,
            validator: emptyValidator,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _FromTextField(
                  label: "Expire",
                  hintText: "Month",
                  controller: expireMonth,
                  validator: emptyValidator,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _FromTextField(
                  label: "",
                  hintText: "Year",
                  controller: expireYear,
                  validator: emptyValidator,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _FromTextField(
            label: "Card holder",
            hintText: "Enter your full name mention on card",
            controller: cardHolder,
            validator: emptyValidator,
          ),
          const SizedBox(height: 24),
          _FromTextField(
            label: "CVV",
            hintText: "*" * 3,
            controller: cvvController,
            validator: emptyValidator,
          ),
          const SizedBox(height: 24),
          CheckboxListTile(
            value: isChecked,
            contentPadding: EdgeInsets.only(),
            controlAffinity: ListTileControlAffinity.leading,
            fillColor: WidgetStateProperty.resolveWith(
              (states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.primary;
                } else {
                  return Colors.transparent;
                }
              },
            ),
            title: Text(
              "Save information for future payment",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onChanged: (v) {
              isChecked = !isChecked;
              setState(() {});
            },
          ),
          const SizedBox(height: 24),
          Align(
            child: AppButton(
              label: "Process payment",
              onTap: onPaymentProceed,
            ),
          )
        ],
      ),
    );
  }
}

class _FromTextField extends StatelessWidget {
  const _FromTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    required this.hintText,
  });
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    ///
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: textTheme.labelLarge,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            fillColor: const Color(0x77F2ECEC),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(53, 53, 53, .35),
              fontWeight: FontWeight.w300,
            ), //todo: add other border config,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black26),
            ),
          ),
        )
      ],
    );
  }
}
