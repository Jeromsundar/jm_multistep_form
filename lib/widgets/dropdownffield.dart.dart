import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T? selectedValue;
  final void Function(T?) onChanged;
  final IconData icon;
  final String? Function(T?)? validator;
  final Color borderColor;
  final TextStyle textStyle;
  final EdgeInsets contentPadding;

  const CustomDropdownField({
    Key? key,
    required this.hintText,
    required this.options,
    this.selectedValue,
    required this.onChanged,
    required this.icon,
    this.validator,
    this.borderColor = Colors.black,
    this.textStyle = const TextStyle(color: Colors.black, fontSize: 14),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: borderColor, size: 18),
          hintText: hintText,
          hintStyle: textStyle.copyWith(color: Colors.black),
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: borderColor, width: 1.5),
          ),
        ),
        items: options
            .map((value) => DropdownMenuItem<T>(
                  value: value,
                  child: Text(value.toString(), style: textStyle),
                ))
            .toList(),
      ),
    );
  }
}
