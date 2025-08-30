import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/functions.dart';
import 'package:ticky/utils/images.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class TimePickerInputWidget extends StatelessWidget {
  final String title;
  final TimeOfDay? initialTime;
  final Function(TimeOfDay? value) onTimePicked;
  final TextEditingController controller;

  const TimePickerInputWidget({
    Key? key,
    required this.title,
    this.initialTime,
    required this.onTimePicked,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleFormComponent(
      text: title,
      child: AppTextField(
        textFieldType: TextFieldType.NUMBER,
        controller: controller,
        decoration: inputDecoration(svgImage: AppSvgIcons.icCalendar, hint: "Choose Time"),
        readOnly: true,
        onTap: () async {
          TimeOfDay? selectedValue = await showTimePicker(
            context: context,
            initialTime: initialTime ?? TimeOfDay.now(),
            errorInvalidText: 'Enter time in valid range',
          );
          onTimePicked.call(selectedValue);
          if (selectedValue != null) {
            controller.text = selectedValue.format(context);
          }
        },
      ),
    );
  }
}
