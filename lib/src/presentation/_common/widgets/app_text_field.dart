import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscureText,
  });

  final String hint;
  final Widget icon;
  final TextEditingController? controller;

  ///  for password
  final bool? obscureText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool? isVisible = widget.obscureText;
  void togglePasswordVisibility() {
    isVisible = !isVisible!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        obscureText: isVisible ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 24),
          suffixIcon: isVisible != null
              ? IconButton(
                  onPressed: togglePasswordVisibility,
                  icon: Icon(isVisible! ? Icons.visibility_off_outlined : Icons.visibility),
                )
              : null,
          prefixIcon: widget.icon,
          hintText: widget.hint,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 108, 108, 108),
          ),
        ),
      ),
    );
  }
}
