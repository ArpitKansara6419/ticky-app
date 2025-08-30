import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/engineer/industry_exp/industry_experience_data.dart';

import '../../../../utils/imports.dart';

class IndustryExperienceWidget extends StatelessWidget {
  final IndustryExperienceData data;
  final Function() onTap;
  final Function(BuildContext) onDeleteTab;

  const IndustryExperienceWidget({Key? key, required this.data, required this.onTap, required this.onDeleteTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListItemWidget(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(AppImages.icExperienceIcon),
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                    20.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.name.validate().capitalizeEachWord(), style: boldTextStyle(size: 16)),
                          8.height,
                          Text(data.experience.validate().replaceFirst("_", "-").replaceAll("_", " ").capitalizeEachWord(), style: secondaryTextStyle(color: context.primaryColor)),
                        ],
                      ),
                    )
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
