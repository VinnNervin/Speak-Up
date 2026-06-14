import 'package:first_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool autocorrect;
  final bool enableSuggestions;
  final IconData icon;
  final String additionalText;
  final Color labelColor;
  final String? Function(String?)? validator;

  const AuthTextfield({
    super.key,
    this.validator,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.icon = Icons.person,
    this.labelColor = AppColors.primary,
    this.additionalText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              textDirection: TextDirection.ltr,
              style: TextStyle(fontWeight: FontWeight.w700, color: labelColor),
            ),
            Spacer(),
            if (additionalText.isNotEmpty)
              Text(
                additionalText,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(icon),
            prefixIconColor: Colors.grey,
            filled: true,
            fillColor: AppColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            labelStyle: const TextStyle(color: Colors.grey),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
