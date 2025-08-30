import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/engineer/spoken_languages/spoken_language_data.dart';

import '../../../../utils/imports.dart';

class SpokenLanguagesWidget extends StatelessWidget {
  final SpokenLanguageData data;
  final Function() onTap;
  final Function(BuildContext) onDeleteTab;

  const SpokenLanguagesWidget({Key? key, required this.data, required this.onTap, required this.onDeleteTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListItemWidget(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(data.languageName.validate().capitalizeFirstLetter(), style: boldTextStyle(size: 16)).expand(),
                    16.width,
                    Text(data.proficiencyLevel.validate().capitalizeFirstLetter().replaceAll("_spoken", ""), style: secondaryTextStyle(color: context.primaryColor)),
                  ],
                ),
                ...{
                  8.height,
                  Row(
                    children: [
                      data.read == 1
                          ? Row(
                              children: [
                                Image(
                                  image: AssetImage(AppImages.icReadIcon),
                                  height: 18,
                                  width: 18,
                                ),
                                3.width,
                                Text("Read", style: boldTextStyle(size: 12)),
                              ],
                            )
                          : Container(),
                      data.read == 1 ? 10.width : 0.width,
                      data.write == 1
                          ? Row(
                              children: [
                                Image(
                                  image: AssetImage(AppImages.icWriteIcon),
                                  height: 18,
                                  width: 18,
                                ),
                                3.width,
                                Text("Write", style: boldTextStyle(size: 12)),
                              ],
                            )
                          : Container(),
                      data.read == 1 ? 10.width : 0.width,
                      data.speak == 1
                          ? Row(
                              children: [
                                Image(
                                  image: AssetImage(AppImages.icSpeakIcon),
                                  height: 18,
                                  width: 18,
                                ),
                                3.width,
                                Text("Speak", style: boldTextStyle(size: 12)),
                              ],
                            )
                          : Container()
                    ],
                  ),
                }
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
