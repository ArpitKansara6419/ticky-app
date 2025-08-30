import 'package:ag_widgets/ag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/images.dart';

class TitleFormComponent extends StatelessWidget {
  final String text;
  final String? richText;
  final String? infoText;
  final TextStyle? titleTextStyle;
  final int? runSpacing;
  final Widget child;
  final bool isRichTextEnabled;
  final bool isInfoIcon;

  const TitleFormComponent({
    Key? key,
    required this.text,
    this.richText,
    this.infoText,
    this.titleTextStyle,
    required this.child,
    this.runSpacing,
    this.isRichTextEnabled = false,
    this.isInfoIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isRichTextEnabled)
            Row(
              children: [
                RichTextWidget(
                  list: [
                    TextSpan(text: text, style: boldTextStyle()),
                    TextSpan(text: " " + richText!, style: boldTextStyle()),
                  ],
                ),
                if (isInfoIcon) ...{
                  6.width,
                  Tooltip(
                    message: infoText.validate(value: "Tapped"),
                    triggerMode: TooltipTriggerMode.tap,
                    margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    showDuration: 20.seconds,
                    child: AppSvgIcons.icPasswordShow.agLoadImage(height: 20, width: 20),
                  ),
                }
              ],
            )
          else
            Text(
              text,
              style: titleTextStyle ?? boldTextStyle(size: 14),
            ),
          (runSpacing ?? 4).height,
          child,
        ],
      ),
    );
  }
}
