import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(decimalDigits: 2, symbol: "");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove all non-numeric characters from the new value.
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Parse the cleaned text as a double.
    double value = double.tryParse(cleanedText) ?? 0.0;

    // Apply the currency formatter to the value.
    String newText = _formatter.format(value / 100);

    // Return the formatted text and selection.
    return TextEditingValue(
      text: newText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      ),
    );
  }
}