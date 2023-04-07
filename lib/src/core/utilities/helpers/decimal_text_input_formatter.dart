import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.contains('.') &&
        newValue.text.substring(newValue.text.indexOf('.') + 1).length >
            decimalRange) {
      // Allow only 2 decimal places
      return oldValue;
    } else {
      return newValue;
    }
  }
}