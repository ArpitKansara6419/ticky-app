import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/view/tickets/widgets/section_widget.dart';

class BuildTicketScopeOfWork extends StatelessWidget {
  final TicketData data;

  const BuildTicketScopeOfWork({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        16.height,
        Text("Scope Of Work", style: boldTextStyle(color: context.primaryColor, size: 16)),
        4.height,
        SectionWidget(child: ReadMoreText(data.scopeOfWork.validate())),
      ],
    );
  }
}
