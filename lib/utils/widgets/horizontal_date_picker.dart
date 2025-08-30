import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/date_utils.dart';

class HorizontalDatePicker extends StatefulWidget {
  final int numberOfDates;
  final Function(DateTime) onDateSelected;
  final List<DateTime> unavailableDates;
  final bool rtl;
  final String locale; // For Shamsi/Jalali support

  const HorizontalDatePicker({
    Key? key,
    required this.numberOfDates,
    required this.onDateSelected,
    this.unavailableDates = const [],
    this.rtl = false,
    this.locale = 'en',
  }) : super(key: key);

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  DateTime _selectedDate = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('d MMM');

    return HorizontalList(
      itemCount: widget.numberOfDates,
      reverse: widget.rtl,
      itemBuilder: (context, index) {
        final date = DateTimeUtils.convertDateTimeToUTC(
          dateTime: DateTime.now(),
        ).add(Duration(days: index));
        final isUnavailable = widget.unavailableDates.contains(date);
        return GestureDetector(
          onTap: () {
            if (!isUnavailable) {
              setState(() {
                _selectedDate = date;
              });
              widget.onDateSelected(date);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: isUnavailable ? Colors.grey[300] : Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: _selectedDate == date
                    ? Colors.blue
                    : isUnavailable
                        ? Colors.grey
                        : Colors.transparent,
              ),
            ),
            child: Center(
              child: Text(
                formatter.format(date),
                style: TextStyle(
                  color: isUnavailable ? Colors.grey : Colors.black,
                  fontWeight: _selectedDate == date ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
