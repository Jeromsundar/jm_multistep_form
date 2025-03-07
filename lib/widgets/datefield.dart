import 'package:flutter/material.dart';

class CustomDateField extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final IconData icon;
  final String hintText;

  const CustomDateField({
    Key? key,
    this.onDateSelected,
    required this.icon,
    required this.hintText,
  }) : super(key: key);

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime? _selectedDate;
  String? _displayText; // Holds the display text for the field

  @override
  void initState() {
    super.initState();
    _displayText = widget.hintText; // Set initial display text as hint text
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2101, 12, 31),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _displayText = '${picked.day}/${picked.month}/${picked.year}'; // Update text
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.black, size: 18),
            hintText: _displayText, // ✅ Hint is set dynamically
            hintStyle: const TextStyle(color: Colors.black, fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
