import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/engineer/technical_certification/technical_certification_data.dart';
import 'package:ticky/utils/widgets/row_widget.dart';
import 'package:ticky/view/engineer/list_document_widget.dart';

import '../../../../utils/imports.dart';

class TechnicalCertificationWidget extends StatelessWidget {
  final TechnicalCertificationData data;
  final Function() onTap;
  final Function(BuildContext) onDeleteTab;

  const TechnicalCertificationWidget({Key? key, required this.data, required this.onTap, required this.onDeleteTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListItemWidget(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(image: AssetImage(AppImages.icCertificationIcon), color: context.primaryColor, height: 50, width: 50),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.certificationType.validate().replaceAll("_", " ").capitalizeEachWord(), style: boldTextStyle(size: 16)),
                      4.height,
                      Text(
                        "#" + data.certificationId.validate(),
                        style: primaryTextStyle(color: context.primaryColor),
                      ),
                      4.height,
                      RowWidget(
                        icon: Icons.date_range,
                        iconColor: context.iconColor,
                        text: formatDate(data.issueDate.validate()),
                        textStyle: primaryTextStyle(),
                      ),
                      4.height,
                      RowWidget(
                        icon: Icons.timer_off_outlined,
                        iconColor: context.iconColor,
                        text: formatDate(data.expireDate.validate()),
                        textStyle: primaryTextStyle(),
                      ),
                      if (daysLeftForExpiry(data.expireDate.validate()).validate().isNotEmpty) ...{
                        8.height,
                        Text('${daysLeftForExpiry(data.expireDate.validate())}', style: secondaryTextStyle(color: context.theme.colorScheme.error, size: 12)),
                      },
                      10.height,
                      if (data.certificateFile.validate().isNotEmpty) ...{
                        6.height,
                        ListDocumentWidget(documents: [data.certificateFile.validate()]),
                      }
                    ],
                  ),
                )
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
          icon: Icon(
            Icons.delete_outlined,
            color: Colors.red,
            size: 20,
          ),
        ).paddingTop(8),
      ],
    );
  }
}
