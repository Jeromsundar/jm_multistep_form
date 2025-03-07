import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isEmail;
  final bool isPhone;
  final bool isNumber;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Color borderColor;
  final Color iconColor;
  final Color fillColor;
  final bool filled;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.hintText,
    this.isEmail = false,
    this.isPhone = false,
    this.isNumber = false,
    this.maxLines = 1,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.borderColor = Colors.grey,
    this.iconColor = Colors.black,
    this.fillColor = Colors.white,
    this.filled = true,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  // Default validation logic
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }

    if (isEmail) {
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
    }

    if (isPhone) {
      final phoneRegex = RegExp(r'^[0-9]{10}$'); // Ensures exactly 10 digits
      if (!phoneRegex.hasMatch(value)) {
        return 'Enter a valid 10-digit phone number';
      }
    }

    if (isNumber) {
      final numberRegex = RegExp(r'^[0-9]+$');
      if (!numberRegex.hasMatch(value)) {
        return 'Enter only numeric values';
      }
    }

    return validator?.call(value); // Allow additional validation
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isPhone || isNumber
                ? TextInputType.number
                : TextInputType.text,
        maxLines: obscureText ? 1 : maxLines,
        obscureText: obscureText,
        validator: _validateInput,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor, size: 20),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
          filled: filled,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: borderColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    );
  }
}
