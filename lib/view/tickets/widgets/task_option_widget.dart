import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/widgets/app_loader.dart';

class TaskOptionWidget extends StatelessWidget {
  final Widget child;
  final bool? hideOptions;
  final Function()? onReject;
  final Function() onAccept;
  final String? acceptName;
  final String? rejectName;
  final bool? acceptLoader;
  final bool? rejectLoader;

  const TaskOptionWidget({
    Key? key,
    required this.child,
    this.onReject,
    this.hideOptions,
    required this.onAccept,
    this.acceptName,
    this.rejectName,
    this.acceptLoader,
    this.rejectLoader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hideOptions.validate()) return child.paddingBottom(8);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.only(bottom: 6, left: 8, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radiusOnly(bottomLeft: defaultRadius, bottomRight: defaultRadius),
          ),
          child: Row(
            children: [
              rejectLoader.validate()
                  ? aimLoader(context, size: 20).expand()
                  : TextButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(side: BorderSide(color: context.dividerColor, width: 0.4), borderRadius: radius()),
                        ),
                      ),
                      onPressed: onReject ??
                          () {
                            //
                          },
                      child: Text(rejectName ?? "Reject", style: boldTextStyle()),
                    ).expand(),
              16.width,
              acceptLoader.validate()
                  ? aimLoader(context, size: 20).expand()
                  : TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(context.primaryColor),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: radius()),
                        ),
                      ),
                      onPressed: onAccept,
                      child: Text(acceptName ?? "Accept", style: boldTextStyle(color: Colors.white)),
                    ).expand(),
            ],
          ),
        ),
      ],
    );
  }
}
