import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class RangeDatePickerInputWidget extends StatelessWidget {
  final String title;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTimeRange? selectedDate;
  final Function(DateTimeRange? value) onDatePicked;
  final TextEditingController controller;
  final void Function()? refreshDirectory;
  final bool Function(DateTime, DateTime?, DateTime?)? selectableDayPredicate;

  const RangeDatePickerInputWidget({
    Key? key,
    required this.title,
    this.firstDate,
    this.lastDate,
    required this.onDatePicked,
    this.selectedDate,
    required this.controller,
    this.refreshDirectory,
    this.selectableDayPredicate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleFormComponent(
      text: title,
      child: AppTextField(
        textFieldType: TextFieldType.NUMBER,
        controller: controller,
        decoration: inputDecoration(svgImage: AppSvgIcons.icCalendar, hint: "Choose Date"),
        readOnly: true,
        onTap: () async {
          if (refreshDirectory != null) {
            refreshDirectory!();
          }
          DateTimeRange? selectedValue = await showDateRangePicker(
            context: context,
            firstDate: DateTime(DateTimeUtils.convertDateTimeToUTC(
                  dateTime: DateTime.now(),
                ).year -
                5),
            lastDate: DateTime(DateTimeUtils.convertDateTimeToUTC(
                  dateTime: DateTime.now(),
                ).year +
                5),
            initialDateRange: selectedDate,
            selectableDayPredicate: selectableDayPredicate,
            builder: (context, child) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.width() * 0.9, maxHeight: context.height() * 0.9),
                child: child,
              ).cornerRadiusWithClipRRect(6).center();
            },
            errorFormatText: 'Enter valid date',
            errorInvalidText: 'Enter date in valid range',
          );
          onDatePicked.call(selectedValue);
          if (selectedValue != null) {
            controller.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(selectedValue.start) + " - " + DateFormat(ShowDateFormat.ddMmmYyyy).format(selectedValue.end);
          }
        },
      ),
    );
  }
}
