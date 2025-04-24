import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DateOfBirthField extends StatefulWidget {
  final TextEditingController controller;

  const DateOfBirthField({super.key, required this.controller});

  @override
  _DateOfBirthFieldState createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Default year
      firstDate: DateTime(1900), // Minimum year
      lastDate: DateTime.now(), // Maximum year (today)
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true, // Prevent manual input
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        hintText: "Enter Date of Birth",
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue.shade900),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Circular Border
          borderSide: BorderSide.none, // Removes the border outline
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
      ),
    );
  }
}