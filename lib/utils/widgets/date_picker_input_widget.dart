import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class DatePickerInputWidget extends StatelessWidget {
  final String title;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? selectedDate;
  final String? showDateFormat;
  final bool? isValidationRequired;
  final Function(DateTime? value) onDatePicked;
  final TextEditingController controller;

  const DatePickerInputWidget({
    Key? key,
    required this.title,
    this.firstDate,
    this.lastDate,
    required this.onDatePicked,
    this.selectedDate,
    required this.controller,
    this.isValidationRequired,
    this.showDateFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleFormComponent(
      text: title,
      child: AppTextField(
        textFieldType: TextFieldType.NUMBER,
        controller: controller,
        decoration: inputDecoration(svgImage: AppSvgIcons.icCalendar, hint: "Select $title".capitalizeFirstLetter()),
        readOnly: true,
        isValidationRequired: isValidationRequired ?? true,
        onTap: () async {
          DateTime? selectedValue = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: firstDate ?? DateTime(1900),
            lastDate: lastDate ??
                DateTimeUtils.convertDateTimeToUTC(
                  dateTime: DateTime.now(),
                ),
            errorFormatText: 'Enter valid date',
            errorInvalidText: 'Enter date in valid range',
          );
          onDatePicked.call(selectedValue);
          if (selectedValue != null) {
            controller.text = DateFormat(showDateFormat ?? ShowDateFormat.yyyyMmDdDash).format(selectedValue);
          }
        },
      ),
    );
  }
}
