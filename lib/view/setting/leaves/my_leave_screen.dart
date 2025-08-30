import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/leaves/leaves_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/leaves/leave_data.dart';
import 'package:ticky/model/leaves/leave_response.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/view/setting/leaves/leave_form_screen.dart';
import 'package:ticky/view/setting/leaves/widget/leave_status_widget.dart';
import 'package:ticky/view/setting/leaves/widget/paid_unpaid_widget.dart';
import 'package:ticky/view/setting/leaves/widget/pdf_preview.dart';

class MyLeaveScreen extends StatefulWidget {
  const MyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<MyLeaveScreen> createState() => _MyLeaveScreenState();
}

class _MyLeaveScreenState extends State<MyLeaveScreen> {
  Future<LeaveResponse>? future;

  List<String> leaveType = ["Balance Leaves", "Approved Leaves", "Pending Leaves", "Rejected Leaves"];

  List<Color> backgroundColor = [
    Color(0xFFdeeced),
    Color(0xFFedf4e4),
    Color(0xFFe2f2f1),
    Color(0xFFf7ebeb),
  ];

  List<Color> borerColorColor = [
    Color(0xFF0f7f84),
    Color(0xFFa5d03c),
    Color(0xFF34bba8),
    Color(0xFFff7970),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool? isUpdated}) async {
    future = LeavesController.getAttendanceApi();
    if (isUpdated.validate()) {
      setState(() {});
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("All leaves"),
      body: FutureBuilder<LeaveResponse>(
          future: future,
          builder: (context, snap) {
            if (snap.hasData) {
              Stats stats = snap.data!.leaveResponseData!.stats!;
              num leaveBalance = 0;
              try {
                leaveBalance = num.parse(stats.leaveBalance.validate(value: "0"));
                leaveStore.freezeLeave = double.parse(stats.freezeLeaveBalance.validate(value: "0"));
              } on Exception catch (e) {
                log(e.toString());
              }
              return AnimatedScrollView(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 100),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedWrap(
                    itemCount: 2,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        width: context.width() / 2 - 20,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: backgroundColor[0], borderRadius: radius(), border: Border.all(color: borerColorColor[0])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leaveType[0], style: boldTextStyle()),
                            8.height,
                            if (leaveStore.freezeLeave > 0)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${(leaveBalance - leaveStore.freezeLeave) < 0 ? 0 : (leaveBalance - leaveStore.freezeLeave).toStringAsFixed(2)}',
                                    style: boldTextStyle(
                                      color: borerColorColor[0],
                                      size: 20,
                                    ),
                                  ),
                                  4.width,
                                  Text(
                                    '(${leaveBalance.toStringAsFixed(2)})',
                                    style: boldTextStyle(
                                      color: borerColorColor[0],
                                      size: 16,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                leaveBalance.toString(),
                                style: boldTextStyle(
                                  color: borerColorColor[0],
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: context.width() / 2 - 20,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: backgroundColor[1], borderRadius: radius(), border: Border.all(color: borerColorColor[1])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leaveType[1], style: boldTextStyle()),
                            8.height,
                            Text(stats.leaveApproved.validate().toString(), style: boldTextStyle(color: borerColorColor[1], size: 20)),
                          ],
                        ),
                      ),
                      Container(
                        width: context.width() / 2 - 20,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: backgroundColor[2], borderRadius: radius(), border: Border.all(color: borerColorColor[2])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leaveType[2], style: boldTextStyle()),
                            8.height,
                            Text(stats.leavePending.validate().toString(), style: boldTextStyle(color: borerColorColor[2], size: 20)),
                          ],
                        ),
                      ),
                      Container(
                        width: context.width() / 2 - 20,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: backgroundColor[3], borderRadius: radius(), border: Border.all(color: borerColorColor[3])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leaveType[3], style: boldTextStyle()),
                            8.height,
                            Text(stats.leaveCancelled.validate().toString(), style: boldTextStyle(color: borerColorColor[3], size: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  16.height,
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Leaves', style: boldTextStyle()),
                      AppButton(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                        color: primaryColor,
                        onTap: () async {
                          await LeaveFormScreen().launch(context);
                          init(isUpdated: true);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white,size: 20,),
                            4.width,
                            Text(
                              "Apply Leave",
                              style: secondaryTextStyle(
                                color: Colors.white,
                                weight: FontWeight.w600,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.height,
                  if (snap.data!.leaveResponseData!.leaveData!.isNotEmpty)
                    AnimatedListView(
                      shrinkWrap: true,
                      itemCount: snap.data!.leaveResponseData!.leaveData!.length,
                      itemBuilder: (context, index) {
                        LeaveData res = snap.data!.leaveResponseData!.leaveData![index];

                        return Container(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          margin: EdgeInsets.only(top: 4, bottom: 4),
                          decoration: BoxDecoration(borderRadius: radius(), color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      PaidUnpaidWidget(data: res).expand(),
                                      LeaveStatusWidget(status: res.leaveApproveStatus.validate()),
                                    ],
                                  ),
                                  8.height,
                                  Row(
                                    children: [
                                      Text('${(res.paidLeaveDays.toDouble() + res.unpaidLeaveDays.toDouble()).toInt()} Days', style: primaryTextStyle(size: 14)),
                                      8.width,
                                      Text('•', style: primaryTextStyle(size: 18, color: primaryColor)),
                                      8.width,
                                      if (res.paidFromDate != null) ...[
                                        Text('${formatDate(res.paidFromDate!)} - ${formatDate(res.paidToDate!)}', style: primaryTextStyle(size: 14)),
                                      ] else if (res.unpaidFromDate != null) ...[
                                        Text('${formatDate(res.unpaidFromDate!)} - ${formatDate(res.unpaidToDate!)}', style: primaryTextStyle(size: 14)),
                                      ] else ...[
                                        Text('${formatDate(res.paidFromDate!)} - ${formatDate(res.unpaidToDate!)}', style: primaryTextStyle(size: 14)),
                                      ]
                                    ],
                                  )
                                ],
                              ),
                              8.height,
                              Divider(height: 0),
                              8.height,
                              Row(
                                children: [
                                  if (res.leaveApproveStatus.validate() != "pending")
                                    Text('${res.leaveApproveStatus.validate().toLowerCase() == 'reject' ? 'Rejected By' : 'Approved By'} Admin', style: primaryTextStyle(size: 14)).expand()
                                  else
                                    Offstage().expand(),
                                  TextButton(
                                    onPressed: () {
                                      if (res.leaveApproveStatus.validate().toLowerCase() != 'approved') {
                                        if (res.paidFromDate != null) {
                                          PdfPreviewNetworkView(file: res.paidDocument.validate(), fileTitle: "Paid Document").launch(context);
                                        } else if (res.unpaidFromDate != null) {
                                          PdfPreviewNetworkView(file: res.unpaidDocument.validate(), fileTitle: "Unpaid Document").launch(context);
                                        }
                                      } else {
                                        if (res.paidFromDate != null) {
                                          PdfPreviewNetworkView(file: res.paidSignedDocument.validate(), fileTitle: "Paid Document").launch(context);
                                        } else if (res.unpaidFromDate != null) {
                                          PdfPreviewNetworkView(file: res.unpaidSignedDocument.validate(), fileTitle: "Unpaid Document").launch(context);
                                        }
                                      }
                                    },
                                    style: ButtonStyle(visualDensity: VisualDensity.compact, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                    child: Text("View Document", style: boldTextStyle(size: 12)),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  else
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.5,
                          child: Center(
                            child: Text(
                              'No Data',
                              style: primaryTextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }
            return snapWidgetHelper(snap, loadingWidget: aimLoader(context));
          }),
    );
  }
}
