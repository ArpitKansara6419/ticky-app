import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/imports.dart';

class PhoneNumberWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? initialCountryCode;
  final String? hint;
  final void Function(Country?)? onInit;
  final Function(Country country) onCountrySelected;
  final FormFieldValidator? validator;
  final IconButton? showSuffixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  const PhoneNumberWidget(
      {Key? key, required this.controller, required this.onCountrySelected, this.onInit, this.initialCountryCode, this.validator, this.hint, this.showSuffixIcon, this.focusNode, this.nextFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      textInputAction: nextFocus != null ? TextInputAction.next : TextInputAction.done,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: validator,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      focusNode: focusNode,
      onFieldSubmitted: (value) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: inputDecoration(
        hint: hint ?? "Enter phone number",
        prefixIcon: CountryCodePicker(
          mode: CountryCodePickerMode.dialog,
          shape: RoundedRectangleBorder(borderRadius: radius(0)),
          elevation: 0,
          onInit: onInit,
          onChanged: onCountrySelected,
          initialSelection: initialCountryCode ?? 'IN',
          showFlag: true,
          showCountryOnly: true,
          flagWidth: 16,
          showOnlyCountryWhenClosed: false,
          searchDecoration: inputDecoration(),
          showDropDownButton: false,
        ),
        suffixIcon: showSuffixIcon,
      ),
    );
  }
}
