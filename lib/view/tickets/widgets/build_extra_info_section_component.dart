import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/view/engineer/list_document_widget.dart';
import 'package:ticky/view/tickets/widgets/section_widget.dart';

class BuildExtraInfoSection extends StatelessWidget {
  final TicketData data;

  const BuildExtraInfoSection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data.pocDetails.validate().isNotEmpty) ...{
            16.height,
            Row(
              children: [
                Text("POC Details", style: boldTextStyle(color: context.primaryColor, size: 16)).expand(),
                Icon(Icons.copy, size: 16).onTap(() {
                  data.pocDetails.validate().copyToClipboard();
                }),
              ],
            ),
            4.height,
            SectionWidget(
              child: Text("${data.pocDetails.validate()}", style: primaryTextStyle()),
            ),
          },
          if (data.reDetails.validate().isNotEmpty) ...{
            16.height,
            Row(
              children: [
                Text("RE Details", style: boldTextStyle(color: context.primaryColor, size: 16)).expand(),
                Icon(Icons.copy, size: 16).onTap(() {
                  data.reDetails.validate().copyToClipboard();
                }),
              ],
            ),
            4.height,
            SectionWidget(
              child: Text("${data.reDetails.validate()}", style: primaryTextStyle()),
            ),
          },
          if (data.callInvites.validate().isNotEmpty) ...{
            16.height,
            Row(
              children: [
                Text("Call Invites", style: boldTextStyle(color: context.primaryColor, size: 16)).expand(),
                Icon(Icons.copy, size: 16).onTap(() {
                  data.callInvites.validate().copyToClipboard();
                }),
              ],
            ),
            4.height,
            SectionWidget(
              child: Text("${data.callInvites.validate()}", style: primaryTextStyle()),
            ),
          },
          if (data.refSignSheet.validate().isNotEmpty) ...{
            16.height,
            Text("Sign of Sheet", style: boldTextStyle(color: context.primaryColor, size: 16)),
            4.height,
            SectionWidget(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  Text("${data.refSignSheet.validate()}", style: primaryTextStyle()).expand(),
                  4.width,
                  ListDocumentWidget(documents: [data.refSignSheet.validate()]),
                ],
              ),
            ),
          },
          if (data.documents.validate().isNotEmpty) ...{
            16.height,
            Text("Documents", style: boldTextStyle(color: context.primaryColor, size: 16)),
            4.height,
            SectionWidget(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${data.documents.validate()}", style: primaryTextStyle()).expand(),
                  4.width,
                  ListDocumentWidget(documents: [data.documents.validate()]),
                ],
              ),
            ),
          },
        ],
      ),
    );
  }
}
