// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/break_data.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/model/tickets/ticket_work_notes.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/view/setting/payouts/component/ticket_payout_view_widget.dart';
import 'package:ticky/view/tickets/components/build_notes_list_component.dart';
import 'package:ticky/view/tickets/components/document_upload_component.dart';
import 'package:ticky/view/tickets/components/food_expense_component.dart';
import 'package:ticky/view/tickets/components/notes_component.dart';
import 'package:ticky/view/tickets/location_verification_screen.dart';
import 'package:ticky/view/tickets/widgets/build_attachment_list_widget.dart';
import 'package:ticky/view/tickets/widgets/build_break_widget.dart';
import 'package:ticky/view/tickets/widgets/build_food_expenses_list_widget.dart';
import 'package:ticky/view/tickets/widgets/section_widget.dart';

class WorkStatusScreen extends StatelessWidget {
  final List<TicketWorks>? workStatus;
  final int ticketId;
  final TicketData ticketData;
  final void Function() onVerifyLocation;
  final void Function() onTaskHoldOrEnd;

  const WorkStatusScreen({
    super.key,
    required this.workStatus,
    required this.ticketId,
    required this.ticketData,
    required this.onVerifyLocation,
    required this.onTaskHoldOrEnd,
  });

  Widget alertBoxComponent({
    required String title,
    required void Function() onTap,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Text(
              title,
              maxLines: 3,
              style: secondaryTextStyle(color: Colors.black, weight: FontWeight.w700),
            ).expand(),
            15.width,
            Icon(Icons.arrow_forward, size: 20, color: Colors.black),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.height,
        Text("Work Status", style: boldTextStyle(color: context.primaryColor, size: 16)),
        8.height,
        if (ticketData.canStartWorkNew() && (ticketData.engineerStatus == null || ticketData.isHold()))
          SectionWidget(
            child: Container(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatDate(DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now()).toString(), outputFormat: ShowDateFormat.ddMmmYyyyEeee), style: boldTextStyle(size: 14)),
                  8.height,
                  Divider(height: 0),
                  8.height,
                  Text(
                    'To start work on this ticket, please verify your current location. Ensure you are within ${getCalculatedDistance(Config.allowedWorkRange)} meters of the work site.',
                    style: secondaryTextStyle(size: 12),
                    textAlign: TextAlign.center,
                  ),
                  8.height,
                  AppButton(
                    width: context.width(),
                    disabledColor: Colors.black.withAlpha((255 * 0.2).toInt()),
                    disabledTextColor: Colors.black,
                    enabled: ticketData.isTimeEnable.validate(),
                    text: "Verify Location",
                    onTap: () async {
                      await LocationVerificationScreen(
                        workAddress: ticketData.toAddressJson(),
                        ticketId: ticketData.id.validate(),
                        ticketData: ticketData,
                        onLocationVerifiedSuccessfully: () {
                          ticketStartWorkStore.refreshTicketDetails(ticketId: ticketData.id.validate());
                          onVerifyLocation();
                        },
                      ).launch(context);
                    },
                  ),
                  if (Platform.isIOS) 12.height,
                ],
              ),
            ),
          ),
        AnimatedListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: workStatus.validate().reversed.length,
          itemBuilder: (context, index) {
            TicketWorks data = workStatus!.reversed.toList()[index];
            return SectionWidget(
              padding: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(formatDate(data.workStartDate.validate(), outputFormat: ShowDateFormat.ddMmmYyyyEeee), style: boldTextStyle(size: 14)).expand(),
                      Visibility(
                        visible: ticketData.isProgress() && ticketData.ticketCurrentWorkId == data.workId.validate(),
                        // visible: true,
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                        child: TextButton(
                          style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(0)), tapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(defaultRadius)),
                              ),
                              builder: (context) => _buildBottomSheet(context, data),
                            );
                          },
                          child: Text('End Task', style: primaryTextStyle(color: Colors.red, size: 14)),
                        ),
                      )
                    ],
                  ).paddingOnly(left: 8, right: 8),
                  Divider(height: 0),
                  8.height,
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time Log: ", style: boldTextStyle(size: 12)),
                        12.height,
                        if (data.workEndDate.validate().isNotEmpty) ...{
                          Text(
                            "📅 ${formatDate(data.workStartDate.validate(), outputFormat: ShowDateFormat.ddMmmYyyyEeee)} - ${formatDate(data.workEndDate.validate(), outputFormat: ShowDateFormat.ddMmmYyyyEeee)}",
                            style: primaryTextStyle(size: 12),
                          ),
                          8.height,
                        },
                        Wrap(
                          children: [
                            buildTimeDecorationWidget(
                              context,
                              iconData: Icons.access_time,
                              name: "Start Time".toUpperCase(),
                              value: formatTickyTime(data.startTime.validate()),
                            ),
                            buildTimeDecorationWidget(
                              context,
                              iconData: Icons.lock_clock_outlined,
                              name: "Break Time".toUpperCase(),
                              value: BreakData.calculateTotalBreakTime(data.breaks.validate()),
                            ),
                            buildTimeDecorationWidget(
                              context,
                              iconData: Icons.access_time_filled_rounded,
                              name: "End Time".toUpperCase(),
                              value: formatTickyTime(data.endTime.validate()),
                            ),
                            buildTimeDecorationWidget(
                              context,
                              iconData: Icons.access_time_filled_rounded,
                              name: "Total Time".toUpperCase(),
                              value: formatTickyTime(data.totalWorkTime.validate()),
                            ),
                          ],
                        ),
                        26.height,
                        Text("Additional Info:", style: boldTextStyle(size: 12)),
                        8.height,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Observer(
                              builder: (context) {
                                return buildAdditionalDataWidget(
                                  context,
                                  hideAddButton: !(ticketData.isProgress() && ticketData.ticketCurrentWorkId == data.workId.validate()),
                                  iconData: Icons.add,
                                  name: '⏸️ Break',
                                  isEmpty: data.breaks.validate().isEmpty,
                                  isLoader: appLoaderStore.appLoadingState[AppLoaderStateName.breakApiState].validate(),
                                  child: data.breaks.validate().isNotEmpty
                                      ? BuildBreakListWidget(
                                          breakList: data.breaks.validate(),
                                          ticketData: ticketData,
                                          onVerifyLocation: onVerifyLocation,
                                        )
                                      : null,
                                  onTap: () => _handleStartBreakClick(context, data, ticketId),
                                );
                              },
                            ),
                            buildAdditionalDataWidget(
                              context,
                              iconData: Icons.add,
                              name: '📝 Note',
                              isEmpty: data.ticketWorkNotes.validate().isEmpty,
                              child: data.ticketWorkNotes.validate().isNotEmpty
                                  ? BuildNotesListWidget(
                                      noteList: data.ticketWorkNotes.validate(),
                                      ticketID: data.ticketId ?? -1000,
                                      onUpdate: (int index) async {
                                        _handleNotesClick(
                                          context,
                                          data,
                                          isUpdate: true,
                                          ticketWorkNotes: data.ticketWorkNotes![index],
                                        );
                                      },
                                    )
                                  : null,
                              onTap: () => _handleNotesClick(context, data),
                            ),
                            buildAdditionalDataWidget(
                              context,
                              iconData: Icons.add,
                              name: '📂 Attachment',
                              isEmpty: data.getAllDocuments().isEmpty,
                              child: data.ticketWorkNotes.validate().isNotEmpty ? BuildAttachmentListWidget(attachmentList: data.getAllDocuments()) : null,
                              onTap: () => _handleAttachmentClick(context, data, ticketId),
                            ),
                            buildAdditionalDataWidget(
                              context,
                              iconData: Icons.add,
                              name: '💰  Expense',
                              isEmpty: data.workexpense.validate().isEmpty,
                              child: data.workexpense.validate().isNotEmpty
                                  ? BuildFoodExpensesListWidget(
                                      foodList: data.workexpense.validate(),
                                      id: data.ticketId ?? -1000,
                                      currencyCode: ticketData.engineer!.payRates!.currencyType.validate(),
                                      onUpdate: (index) => _handleFoodClick(
                                        context,
                                        data,
                                        ticketId,
                                        workExpenseIndex: index,
                                      ),
                                    )
                                  : null,
                              onTap: () => _handleFoodClick(context, data, ticketId),
                            ),
                            if (ticketData.isClose() || ticketData.isHold() || ticketData.isBreak()) ...{
                              16.height,
                              TicketPayoutViewWidget(data: data, ticketData: ticketData),
                            }
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ).paddingTop(8);
          },
        ),
      ],
    );
  }

  String getCurrencyValue({required num currencyValue}) {
    return ticketData.engineer!.payRates!.currencyType.validate().getCurrencyType() + currencyValue.toString();
  }

  void _handleNotesClick(
    BuildContext context,
    TicketWorks data, {
    bool isUpdate = false,
    TicketWorkNotes? ticketWorkNotes,
  }) async {
    ticketStartWorkStore.notesCont.clear();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          child: NotesComponent(
            ticketNumber: data.ticketId.validate(),
            data: data,
            ticketWorkNotes: ticketWorkNotes,
          ),
        );
      },
    );
    ticketStartWorkStore.refreshTicketDetails(ticketId: ticketId);
  }

  void _handleStartBreakClick(BuildContext context, TicketWorks data, int ticketId) async {
    await showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "BreakTime",
      subTitle: "Refresh, Recharge, Restart.",
      onAccept: (context) async {
        await ticketStartWorkStore.addBreak(data: data);
        ticketStartWorkStore.refreshTicketDetails(ticketId: ticketId);
        finish(context);
      },
    );
  }

  void _handleEndClick(BuildContext context, TicketWorks data, int ticketId) async {
    await showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "End Work for Today",
      subTitle: "Make sure all tasks are completed and reviewed before proceeding.",
      positiveText: "Confirm",
      dialogType: DialogType.CONFIRMATION,
      onAccept: (c) async {
        await ticketStartWorkStore.endTicket(data: data, status: "hold");
        ticketStartWorkStore.refreshTicketDetails(ticketId: ticketId);
        finish(context);
      },
    );
  }

  void _handleEndTicketAndCloseClick(BuildContext context, TicketWorks data, int ticketId) async {
    await showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "Close Ticket",
      dialogType: DialogType.CONFIRMATION,
      subTitle: "Ensure all tasks are completed and no further updates are needed",
      positiveText: "Confirm",
      onAccept: (c) async {
        await ticketStartWorkStore.endTicket(data: data, status: "close");
        ticketStartWorkStore.refreshTicketDetails(ticketId: ticketId);
        finish(context);
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context, TicketWorks data) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('How Would You Like to Proceed?', style: boldTextStyle(size: 18)),
          Text('Continue, finish, or hold work effortlessly.', style: secondaryTextStyle()),
          SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDetailedButton(
                context,
                icon: Icons.pause_circle_outline,
                title: 'End Work for today',
                description: '📌 Finish tasks, review, and rest.',
                finishTaskType: FinishTaskType.HoldTask,
                onTap: () async {
                  onTaskHoldOrEnd();
                  _handleEndClick(context, data, ticketId);
                },
              ),
              _buildDetailedButton(
                context,
                icon: Icons.check_circle_outline,
                title: 'Close Ticket',
                description: '✅ Complete the ticket by today.',
                finishTaskType: FinishTaskType.EndTask,
                onTap: () async {
                  onTaskHoldOrEnd();
                  _handleEndTicketAndCloseClick(context, data, ticketId);
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDetailedButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required FinishTaskType finishTaskType,
  }) {
    bool primaryButton = (finishTaskType == FinishTaskType.HoldTask && ticketData.ticketDayType == TicketDayType.StartingDay) ||
        (finishTaskType == FinishTaskType.HoldTask && ticketData.ticketDayType == TicketDayType.MiddleDay) ||
        (finishTaskType == FinishTaskType.EndTask && (ticketData.ticketDayType == TicketDayType.EndingDay || ticketData.ticketDayType == TicketDayType.SameDay));
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: primaryButton ? context.primaryColor : Colors.transparent,
              width: primaryButton ? 0 : 2,
            ),
            color: primaryButton ? context.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: primaryButton ? Colors.white : Colors.black),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryButton ? Colors.white : Colors.black),
              ).fit(),
              SizedBox(height: 8),
              Text(
                description,
                maxLines: 2,
                style: TextStyle(fontSize: 14, color: primaryButton ? Colors.white70 : Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAttachmentClick(BuildContext context, TicketWorks data, int ticketId) async {
    ticketStartWorkStore.attachmentFiles.clear();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          child: DocumentUploadComponent(ticketNumber: data.ticketId.validate(), data: data),
        );
      },
    );
    ticketStartWorkStore.refreshTicketDetails(ticketId: ticketId);
  }

  void _handleFoodClick(BuildContext context, TicketWorks data, int ticketId, {int? workExpenseIndex}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          child: TicketExpenseComponent(
            ticketNumber: data.ticketId.validate(),
            data: data,
            workExpense: data.workexpense != null && data.workexpense!.isNotEmpty && workExpenseIndex != null ? data.workexpense![workExpenseIndex] : null,
          ),
        );
      },
    );
    ticketStartWorkStore.expenseNameCont.clear();
    ticketStartWorkStore.expenseCostCont.clear();
    ticketStartWorkStore.uploadedFile = [];
    ticketStartWorkStore.refreshTicketDetails(ticketId: ticketId);
  }

  Widget buildAdditionalDataWidget(
    BuildContext context, {
    required IconData iconData,
    required String name,
    bool isLoader = false,
    bool isEmpty = false,
    String? value,
    Widget? child,
    bool hideAddButton = false,
    Widget? replaceAddButton,
    required Function() onTap,
  }) {
    return Container(
      width: context.width(),
      margin: EdgeInsets.only(top: 4, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: radiusOnly(topRight: defaultRadius, topLeft: defaultRadius, bottomRight: isEmpty ? defaultRadius : 0, bottomLeft: isEmpty ? defaultRadius : 0),
            ),
            child: InkWell(
              onTap: hideAddButton ? null : onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name, style: boldTextStyle(color: Colors.white, size: 14)),
                  Spacer(),
                  hideAddButton
                      ? Offstage()
                      : ButtonAppLoader(
                          size: 24,
                          isLoading: isLoader,
                          child: replaceAddButton ?? Icon(iconData, color: Colors.white, size: 16),
                        ),
                ],
              ),
            ),
          ),
          if (child != null) ...{
            Container(
              width: context.width(),
              decoration: BoxDecoration(color: context.scaffoldBackgroundColor, borderRadius: radiusOnly(bottomRight: defaultRadius, bottomLeft: defaultRadius)),
              child: child,
            ),
          }
        ],
      ),
    );
  }

  Widget buildTimeDecorationWidget(BuildContext context, {required IconData iconData, required String name, String? value}) {
    return Container(
      width: context.width() / 4 - 12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value.validate(value: "--"), style: boldTextStyle(size: 14)),
          4.height,
          Text("${name}".toUpperCase(), style: secondaryTextStyle(size: 10)),
        ],
      ),
    );
  }
}
