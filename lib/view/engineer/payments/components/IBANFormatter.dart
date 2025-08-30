import 'package:flutter/services.dart';

class IBANFormatter extends TextInputFormatter {
  static const int minLength = 6;
  static const int maxLength = 34; // Max IBAN length globally

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove non-alphanumeric characters and convert to uppercase
    String text = newValue.text.replaceAll(RegExp(r'\W+'), '').toUpperCase();

    // Restrict length between 6 and 34 characters
    if (text.length > maxLength) {
      text = text.substring(0, maxLength);
    }

    // Format IBAN in groups of 4 characters
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
