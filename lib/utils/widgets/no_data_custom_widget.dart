import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/imports.dart';

class NoDataCustomWidget extends StatelessWidget {
  final String title;
  final String? noData;

  const NoDataCustomWidget({Key? key, required this.title, this.noData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoDataWidget(
      imageWidget: (noData ?? AppImages.noDataJson).agLoadImage(height: 120, width: 120),
      imageSize: Size(150, 150),
      title: title,
      titleTextStyle: boldTextStyle(size: 16, color: Colors.black),
    ).center();
  }
}

extension stringExtension on String {
  Widget get noDataWidget => NoDataCustomWidget(title: this);

  String get getImageWithBaseUrl {
    if (this.isNotEmpty) {
      return Config.imageUrl + this;
    }
    return "";
  }
}
