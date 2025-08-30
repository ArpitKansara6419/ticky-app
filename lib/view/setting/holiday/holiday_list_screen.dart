import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/holiday/holiday_controller.dart';
import 'package:ticky/model/holiday/holiday_data.dart';
import 'package:ticky/model/holiday/holiday_response.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/view/setting/holiday/widget/holiday_widget.dart';

class HolidayListScreen extends StatefulWidget {
  const HolidayListScreen({Key? key}) : super(key: key);

  @override
  State<HolidayListScreen> createState() => _HolidayListScreenState();
}

class _HolidayListScreenState extends State<HolidayListScreen> {
  Future<HolidayResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = HolidayController.getHolidayListApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Holidays"),
      body: FutureBuilder<HolidayResponse>(
        future: future,
        builder: (context, snap) {
          if (snap.hasData) {
            return AnimatedListView(
              padding: EdgeInsets.all(16),
              itemCount: snap.data!.holidayData!.reversed.length,
              itemBuilder: (context, index) {
                HolidayData data = snap.data!.holidayData!.reversed.toList()[index];
                return HolidayWidget(data: data);
              },
            );
          }
          return snapWidgetHelper(snap, loadingWidget: aimLoader(context));
        },
      ),
    );
  }
}
