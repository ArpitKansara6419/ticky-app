import 'package:ag_widgets/ag_widgets.dart';
import 'package:ag_widgets/extension/list_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/auth/timezone_response.dart';
import 'package:ticky/utils/functions.dart';

class TimezoneDropdown extends StatefulWidget {
  final List<Timezones> timezones;
  final Timezones? initialValue;
  final void Function(Timezones?)? onChanged;

  const TimezoneDropdown({
    Key? key,
    required this.timezones,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _TimezoneDropdownState createState() => _TimezoneDropdownState();
}

class _TimezoneDropdownState extends State<TimezoneDropdown> {
  late Timezones? selectedTimezone;

  @override
  void initState() {
    super.initState();
    selectedTimezone = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant TimezoneDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only update if initialValue or the list has changed
    if (widget.initialValue != oldWidget.initialValue || widget.timezones != oldWidget.timezones) {
      selectedTimezone = widget.timezones.firstWhereOrNull(
        (tz) => tz == widget.initialValue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.timezones.isSingle,
      child: DropdownButtonFormField<Timezones>(
        decoration: inputDecoration(hint: ""),
        isExpanded: true,
        hint: Text(
          "Select Timezone",
          style: secondaryTextStyle(size: 12),
        ),
        dropdownColor: context.cardColor,
        value: selectedTimezone != null && widget.timezones.contains(selectedTimezone) ? selectedTimezone : null,
        items: widget.timezones.map((timezone) {
          return DropdownMenuItem<Timezones>(
            value: timezone,
            child: Row(
              children: [
                Text(
                  timezone.zoneName.validate(),
                  maxLines: 2,
                  style: boldTextStyle(size: 13),
                ),
                8.width,
                Text(
                  timezone.gmtOffsetName.validate().wrapWithBracket(BracketType.rounded),
                  maxLines: 2,
                  style: primaryTextStyle(size: 10),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedTimezone = value;
          });
          widget.onChanged?.call(value);
        },
      ),
    );
  }
}
