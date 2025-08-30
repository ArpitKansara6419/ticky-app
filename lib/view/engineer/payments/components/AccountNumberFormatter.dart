import 'package:flutter/services.dart';

class AccountNumberFormatter extends TextInputFormatter {
  static const int minLength = 6;
  static const int maxLength = 20;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove non-alphanumeric characters
    String text = newValue.text.replaceAll(RegExp(r'\W+'), '').toUpperCase();

    // Restrict length
    if (text.length > maxLength) {
      text = text.substring(0, maxLength);
    }

    // Format with spaces every 4 characters
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
