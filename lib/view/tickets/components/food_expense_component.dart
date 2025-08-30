import 'dart:io';

import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/model/tickets/workexpense.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/master_data_dropdown_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/common_widget.dart';

class TicketExpenseComponent extends StatefulWidget {
  final int ticketNumber;
  final TicketWorks data;
  final Workexpense? workExpense;

  const TicketExpenseComponent({
    Key? key,
    required this.ticketNumber,
    required this.data,
    this.workExpense,
  }) : super(key: key);

  @override
  State<TicketExpenseComponent> createState() => _TicketExpenseComponentState();
}

class _TicketExpenseComponentState extends State<TicketExpenseComponent> {
  List<String> expenseType = [
    "Travel",
    "Tools",
    "Stay",
    "Food",
    "Miscellaneous",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.workExpense != null) {
      // mainLog(message: jsonEncode(widget.workExpense!.toJson()), label: 'Work Expense => ');
      if (widget.workExpense!.name != null && widget.workExpense!.name!.isNotEmpty) {
        ticketStartWorkStore.expenseNameCont.text = expenseType.firstWhereOrNull(
              (element) => element.toLowerCase() == widget.workExpense!.name?.toLowerCase(),
            ) ??
            '';
      }
      if (widget.workExpense!.expense != null) {
        ticketStartWorkStore.expenseCostCont.text = widget.workExpense!.expense.toString();
      }
      if (widget.workExpense!.document != null && widget.workExpense!.document!.isNotEmpty) {
        ticketStartWorkStore.uploadedFile = [File(widget.workExpense!.document!)];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ticketStartWorkStore.expenseFromState,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTitleWidget("Expense Details"),
          ScreenSubTitleWidget("Record costs and upload supporting documents."),
          16.height,
          TitleFormComponent(
            text: 'Expense Type*',
            child: DropdownButtonFormField(
              validator: (value) {
                if (value.validate().isEmpty) return errorThisFieldRequired;

                return null;
              },
              items: List.generate(
                expenseType.length,
                (index) {
                  String res = expenseType[index];
                  return DropdownMenuItem(
                    value: res,
                    child: Text(res.validate(), style: primaryTextStyle()),
                  );
                },
              ),
              decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Select"),
              value: ticketStartWorkStore.expenseNameCont.text.isNotEmpty ? ticketStartWorkStore.expenseNameCont.text : null,
              onChanged: (value) {
                ticketStartWorkStore.expenseNameCont.text = value.validate().trim();
              },
            ),
          ),
          16.height,
          TitleFormComponent(
            text: 'Cost*',
            child: AppTextField(
              controller: ticketStartWorkStore.expenseCostCont,
              textFieldType: TextFieldType.NUMBER,
              isValidationRequired: true,
              decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: ""),
            ),
          ),
          16.height,
          TitleFormComponent(
            text: 'Documents',
            child: Observer(
              builder: (context) {
                return AppTextField(
                  textFieldType: TextFieldType.EMAIL_ENHANCED,
                  isValidationRequired: false,
                  readOnly: true,
                  suffix: FilePickerFunctions.FilePickerPopupMenu(
                    icon: Icons.upload,
                    onFileSelection: (file) async {
                      ticketStartWorkStore.uploadedFile = await file;
                      setState(() {});
                    },
                  ),
                  decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Select Here"),
                );
              },
            ),
          ),
          16.height,
          Observer(
            builder: (context) {
              return Wrap(
                runSpacing: 16,
                spacing: 16,
                children: List.generate(
                  ticketStartWorkStore.uploadedFile.length,
                  (index) {
                    var data = ticketStartWorkStore.uploadedFile[index];
                    return getFileTypeImage(data.path).agLoadImage(height: 70, width: 70);
                  },
                ),
              );
            },
          ),
          SizedBox(height: 24),
          Observer(builder: (context) {
            return ButtonAppLoader(
              isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.foodExpenseApiState].validate(),
              child: AppButton(
                width: context.width(),
                text: widget.workExpense != null ? "Update" : "Save",
                onTap: () {
                  if (ticketStartWorkStore.expenseFromState.currentState!.validate()) {
                    ticketStartWorkStore.expenseFromState.currentState!.save();
                    ticketStartWorkStore.addFoodExpenses(data: widget.data, id: widget.workExpense?.id);
                  }
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
