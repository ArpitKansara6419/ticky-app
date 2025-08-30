import 'package:ag_widgets/ag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/engineer/documents/document_data.dart';
import 'package:ticky/utils/widgets/row_widget.dart';
import 'package:ticky/view/engineer/list_document_widget.dart';

import '../../../../utils/imports.dart';

class DocumentWidget extends StatelessWidget {
  final DocumentData data;
  final Function() onTap;
  final Function(BuildContext) onDeleteTab;

  const DocumentWidget({Key? key, required this.data, required this.onTap, required this.onDeleteTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListItemWidget(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: data.media != null && data.media!.isNotEmpty ? 8 : 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSvgIcons.icDocument.agLoadImage(color: Colors.black, height: 35, width: 35),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.documentType.validate().replaceAll("_", " ").capitalizeEachWord(), style: boldTextStyle(size: 16)),
                    4.height,
                    RowWidget(
                      icon: Icons.date_range,
                      iconColor: context.iconColor,
                      text: formatDate(data.issueDate.validate()),
                    ),
                    4.height,
                    RowWidget(
                      icon: Icons.timer_off_outlined,
                      iconColor: context.iconColor,
                      text: formatDate(data.expiryDate.validate()),
                    ),
                    if (daysLeftForExpiry(data.expiryDate.validate()).validate().isNotEmpty) ...{
                      8.height,
                      Text('${daysLeftForExpiry(data.expiryDate.validate())}', style: secondaryTextStyle(color: context.theme.colorScheme.error, size: 12)),
                    },
                    if (data.media.validate().isNotEmpty) ...{
                      8.height,
                      ListDocumentWidget(documents: data.media!),
                    }
                  ],
                ).expand(),
              ],
            ),
          ),
        ).expand(),
        IconButton(
          style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
          onPressed: () {
            showConfirmDialogCustom(
              context,
              dialogType: DialogType.DELETE,
              title: "Confirm Deletion",
              subTitle: "This will permanently delete the selected document. Do you wish to proceed?",
              onAccept: onDeleteTab,
            );
          },
          icon: Icon(Icons.delete_outlined, color: Colors.red, size: 20),
        ).paddingBottom(8),
      ],
    );
  }
}
