import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/engineer/education/education_data.dart';
import 'package:ticky/utils/functions.dart';
import 'package:ticky/utils/widgets/row_widget.dart';
import 'package:ticky/view/engineer/list_document_widget.dart';

class EducationWidget extends StatelessWidget {
  final EducationData data;
  final Function() onTap;
  final Function(BuildContext) onDeleteTab;

  const EducationWidget({Key? key, required this.data, required this.onTap, required this.onDeleteTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListItemWidget(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.degreeName.validate(), style: boldTextStyle()),
                        4.height,
                        Text(data.universityName.validate(), style: secondaryTextStyle(color: context.primaryColor)),
                        4.height,
                        RowWidget(
                          icon: Icons.date_range,
                          iconColor: context.iconColor,
                          text: formatDate(data.issueDate.validate()),
                          textStyle: primaryTextStyle(),
                        ),
                        7.height,
                        if (data.mediaFiles.validate().isNotEmpty) ...{
                          6.height,
                          ListDocumentWidget(documents: data.mediaFiles.validate()),
                        }
                      ],
                    ).expand(),
                    16.width,
                  ],
                ),
              ),
            ],
          ),
        ).expand(),
        IconButton(
          style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
          onPressed: () {
            showConfirmDialogCustom(
              context,
              title: "Remove Education Entry",
              subTitle: "Are you sure you want to delete this education entry? This action cannot be undone.",
              positiveText: "Remove",
              onAccept: onDeleteTab,
            );
          },
          icon: Icon(Icons.delete_outlined, color: Colors.red, size: 20),
        ).paddingBottom(8)
      ],
    );
  }
}
