import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/geo_services/geo_functions.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/icon_text_widget.dart';
import 'package:ticky/view/tickets/widgets/section_widget.dart';

class BuildMapWidget extends StatelessWidget {
  final num ticketID;
  final String address;
  final double? addressLat;
  final double? addressLng;

  final bool? inProgress;
  final void Function(bool isInRange)? checkIsInRange;

  const BuildMapWidget({
    Key? key,
    required this.ticketID,
    required this.address,
    this.addressLat,
    this.addressLng,
    this.inProgress,
    this.checkIsInRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Text("Task Location", style: boldTextStyle(color: context.primaryColor, size: 16)),
        4.height,
        SectionWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTextWidget(
                icon: Icons.location_on_outlined,
                text: address.capitalizeEachWord(),
                iconSize: 20,
              ),
              10.height,
              if (inProgress.validate()) ...[
                StreamBuilder(
                  stream: Location().onLocationChanged,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      double calculateData = calculateDistanceWithoutFuture(snap.data!.latitude.validate(), snap.data!.longitude.validate(), addressLat.validate(), addressLng.validate());
                      if (checkIsInRange != null) {
                        checkIsInRange!(calculateData <= 3000);
                      }
                      return IconTextWidget(
                        icon: Icons.social_distance_outlined,
                        text: "${calculateData > 1000 ? '${(calculateData / 1000).toStringAsFixed(2)} KM' : '${calculateData} meters'}" + " away from you",
                        iconSize: 20,
                      );
                    }
                    return snapWidgetHelper(snap, loadingWidget: aimLoader(context, size: 20));
                  },
                ),
                16.height,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
