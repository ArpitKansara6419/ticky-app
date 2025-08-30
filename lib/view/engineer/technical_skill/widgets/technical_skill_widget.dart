import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/engineer/technical_skill/technical_skills_data.dart';

import '../../../../utils/imports.dart';

class TechnicalSkillWidget extends StatelessWidget {
  final TechnicalSkillData data;
  final Function() onTap;
  final Function(BuildContext) onDeleteTab;

  const TechnicalSkillWidget({Key? key, required this.data, required this.onTap, required this.onDeleteTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListItemWidget(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Image(
                  image: AssetImage(AppImages.icTechnicalSkillsIcon),
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
                16.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name.validate().replaceAll("_", " ").capitalizeEachWord(), style: boldTextStyle(size: 14)),
                      7.height,
                      ...{
                        Text("${data.level.validate().replaceAll("_", " ").capitalizeEachWord().replaceAll("Technical Skills", "")}", style: secondaryTextStyle()),
                      },
                    ],
                  ),
                ),
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
        ),
      ],
    );
  }
}
