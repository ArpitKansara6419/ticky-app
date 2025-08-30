import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/setting/payouts/component/ticket_payout_view_widget.dart';

class TicketPayoutWidget extends StatefulWidget {
  const TicketPayoutWidget({super.key, required this.ticketData});

  final TicketData ticketData;

  @override
  State<TicketPayoutWidget> createState() => _TicketPayoutWidgetState();
}

class _TicketPayoutWidgetState extends State<TicketPayoutWidget> with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 4, top: 4),
        decoration: BoxDecoration(borderRadius: radius(), color: context.primaryColor.withAlpha(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("#${widget.ticketData.ticketCode}", style: boldTextStyle(size: 14)),
                Spacer(),
                Text("${formatDate(widget.ticketData.taskStartDate.validate())}", style: primaryTextStyle(size: 14)),
              ],
            ),
            4.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${widget.ticketData.taskName}", style: primaryTextStyle(size: 14)).expand(),
                if (widget.ticketData.ticketWorks != null &&
                    widget.ticketData.ticketWorks!.isNotEmpty &&
                    widget.ticketData.ticketWorks!.every(
                      (element) => element.engineerPayoutStatus != null && element.engineerPayoutStatus!.isNotEmpty && element.engineerPayoutStatus!.toLowerCase() == 'paid',
                    ))
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Paid",
                        style: primaryTextStyle(size: 13, color: darkGreenColor, weight: FontWeight.bold),
                      ),
                      3.width,
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: Colors.green,
                      ),
                    ],
                  ),
              ],
            ),
            8.height,
            AnimatedSize(
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              reverseDuration: Duration(milliseconds: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isExpanded) ...[
                    AnimatedListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.ticketData.ticketWorks!.length,
                      listAnimationType: ListAnimationType.None,
                      itemBuilder: (context, index) {
                        TicketWorks data = widget.ticketData.ticketWorks.validate()[index];
                        return TicketPayoutViewWidget(data: data, index: index, ticketData: widget.ticketData);
                      },
                    ),
                    8.height,
                  ],
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      color: Colors.black.withAlpha(
                        (255 * 0.5).toInt(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
