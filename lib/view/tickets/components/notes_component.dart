import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/model/tickets/ticket_work_notes.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/functions.dart';
import 'package:ticky/utils/images.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/view/common_widget.dart';

import '../../../utils/widgets/title_form_component.dart';

class NotesComponent extends StatelessWidget {
  final int ticketNumber;
  final TicketWorks data;
  final TicketWorkNotes? ticketWorkNotes;

  const NotesComponent({
    Key? key,
    required this.ticketNumber,
    required this.data,
    this.ticketWorkNotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mainLog(message: jsonEncode(data.toJson()), label: 'jsonEncode(data.toJson()) => ');
    if (ticketWorkNotes != null && ticketWorkNotes!.note != null && ticketWorkNotes!.note!.isNotEmpty) {
      ticketStartWorkStore.notesCont.text = ticketWorkNotes!.note!;
    }
    return Form(
      key: ticketStartWorkStore.notesFromState,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTitleWidget("Work Notes"),
          ScreenSubTitleWidget("Add notes to document task details and observations."),
          16.height,
          TitleFormComponent(
            text: 'Notes*',
            child: AppTextField(
              controller: ticketStartWorkStore.notesCont,
              textFieldType: TextFieldType.MULTILINE,
              minLines: 3,
              maxLines: null,
              validator: (value) {
                if (value.validate().isEmpty) return errorThisFieldRequired;
                return null;
              },
              isValidationRequired: true,
              decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
              autoFocus: true,
            ),
          ),
          16.height,
          Observer(builder: (context) {
            return ButtonAppLoader(
              isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.ticketsNotesApiState].validate(),
              child: AppButton(
                width: context.width(),
                text: ticketWorkNotes != null && ticketWorkNotes!.id != null ? "Update" : "Save",
                onTap: () async {
                  if (ticketStartWorkStore.notesFromState.currentState!.validate()) {
                    ticketStartWorkStore.notesFromState.currentState!.save();
                    await ticketStartWorkStore.addNotes(
                      data: data,
                      isUpdate: ticketWorkNotes != null && ticketWorkNotes!.id != null,
                      id: ticketWorkNotes?.id,
                    );
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
