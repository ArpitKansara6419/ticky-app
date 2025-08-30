import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/workexpense.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/engineer/list_document_widget.dart';

class BuildFoodExpensesListWidget extends StatelessWidget {
  final int id;
  final List<Workexpense> foodList;
  final String currencyCode;
  final void Function(int index) onUpdate;

  const BuildFoodExpensesListWidget({
    Key? key,
    required this.id,
    required this.foodList,
    required this.currencyCode,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 8),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: foodList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Workexpense data = foodList[index];
          return Row(
            children: [
              Text(data.name.validate(), style: boldTextStyle()),
              if (data.document.validate().isNotEmpty) ...{
                8.width,
                ListDocumentWidget(documents: [data.document.validate()], fileSize: 24),
              },
              Spacer(),
              Text(currencyCode.validate().getCurrencyType() + data.expense.validate().toString(), style: secondaryTextStyle()),
              10.width,
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onUpdate(index);
                },
                child: Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.black,
                ),
              ),
              10.width,
              Observer(
                builder: (context) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    ticketStartWorkStore.deleteFoodExpenses(
                      id: data.id.validate(),
                      ticketId: id,
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
              ),
              12.width,
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 8);
        },
      ),
    );
  }
}
