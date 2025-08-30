import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/tickets/ticket_controller.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/model/tickets/ticket_response.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/setting/payouts/component/ticket_payout_widget.dart';

class PayoutDetailsScreen extends StatefulWidget {
  const PayoutDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PayoutDetailsScreen> createState() => _PayoutDetailsScreenState();
}

class _PayoutDetailsScreenState extends State<PayoutDetailsScreen> {
  int selectedYear = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  ).year;
  int selectedMonth = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  ).month;
  TicketPayoutType _selectedFilter = TicketPayoutType.All;
  final TextEditingController searchController = TextEditingController();

  List<int> years = [2020, 2021, 2022, 2023, 2024, 2025];
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  List<TicketData> ticketList = [];
  List<TicketData> filteredList = [];
  List<TicketData> searchedTicketList = [];

  Future<TicketListResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = TicketController.getTicketListApi(status: "close", engineer_status: "hold", month: selectedMonth, year: selectedYear);
    if (future != null) {
      future!.then(
        (value) {
          if (value.ticketData != null && value.ticketData!.isNotEmpty) {
            ticketList = value.ticketData!;
            setListAccordingToRadio();
          }
        },
      );
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void setListAccordingToRadio() {
    if (ticketList.isNotEmpty) {
      if (_selectedFilter == TicketPayoutType.All) {
        filteredList = ticketList;
      } else if (_selectedFilter == TicketPayoutType.Paid) {
        filteredList = ticketList
            .where(
              (element) =>
                  element.ticketWorks != null &&
                  element.ticketWorks!.isNotEmpty &&
                  element.ticketWorks!.every(
                    (element) {
                      return element.engineerPayoutStatus != null && element.engineerPayoutStatus!.isNotEmpty && element.engineerPayoutStatus!.toLowerCase().contains("paid");
                    },
                  ),
            )
            .toList();
      } else if (_selectedFilter == TicketPayoutType.Unpaid) {
        filteredList = ticketList
            .where(
              (element) =>
                  element.ticketWorks != null &&
                  element.ticketWorks!.isNotEmpty &&
                  element.ticketWorks!.every(
                    (element) {
                      return element.engineerPayoutStatus != null && element.engineerPayoutStatus!.isNotEmpty && element.engineerPayoutStatus!.toLowerCase() != "paid";
                    },
                  ),
            )
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Payouts"),
      body: Padding(
        padding: EdgeInsets.only(bottom: Platform.isIOS ? 24 : 0),
        child: AnimatedScrollView(
          listAnimationType: ListAnimationType.None,
          padding: EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Text("${months[selectedMonth - 1]}, 2025", style: boldTextStyle()).expand(),
                IconButton(
                  onPressed: () {
                    showInDialog(
                      context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Select Month & Year", style: boldTextStyle()),
                            16.height,
                            DropdownButtonFormField<String>(
                              value: months[selectedMonth - 1],
                              items: months.map((String month) {
                                return DropdownMenuItem<String>(
                                  value: month,
                                  child: Text(
                                    month,
                                    style: primaryTextStyle(),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMonth = months.indexOf(newValue!) + 1;
                                });
                              },
                              decoration: inputDecoration(hint: "Choose"),
                            ),
                            16.height,
                            DropdownButtonFormField<int>(
                              value: selectedYear,
                              items: years.map((int year) {
                                return DropdownMenuItem<int>(
                                  value: year,
                                  child: Text(
                                    year.toString(),
                                    style: primaryTextStyle(),
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                setState(() {
                                  selectedYear = newValue.validate();
                                });
                              },
                              decoration: inputDecoration(hint: "Choose"),
                            ),
                            16.height,
                            AppButton(
                              text: "Apply",
                              width: context.width(),
                              onTap: () {
                                init();
                                finish(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: context.primaryColor,
                  ),
                ),
              ],
            ),
            8.height,
            TitleFormComponent(
              text: 'Search Ticket',
              child: AppTextField(
                cursorHeight: 16,
                textAlignVertical: TextAlignVertical.center,
                textFieldType: TextFieldType.NAME,
                controller: searchController,
                decoration: inputDecoration(hint: 'Search Ticket by Ticket Number', svgImage: AppSvgIcons.icEmail),
                onChanged: (value) {
                  if (ticketList.isNotEmpty && filteredList.isNotEmpty && value.isNotEmpty) {
                    setState(
                      () {
                        setListAccordingToRadio();
                        searchedTicketList = filteredList.where((element) {
                          if (element.ticketCode != null && element.ticketCode!.isNotEmpty) {
                            return element.ticketCode!.toLowerCase().contains(value.toLowerCase());
                          }
                          return element.ticketCode.toString().contains(value);
                        }).toList();
                      },
                    );
                  }
                },
              ),
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildRadioOption(
                    label: 'All',
                    ticketPayoutType: TicketPayoutType.All,
                  ),
                ),
                Expanded(
                  child: _buildRadioOption(
                    label: 'Paid',
                    ticketPayoutType: TicketPayoutType.Paid,
                  ),
                ),
                Expanded(
                  child: _buildRadioOption(
                    label: 'Unpaid',
                    ticketPayoutType: TicketPayoutType.Unpaid,
                  ),
                ),
              ],
            ),
            16.height,
            FutureBuilder<TicketListResponse>(
              future: future,
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.connectionState == ConnectionState.waiting) return aimLoader(context);
                  if (snap.data!.ticketData.validate().isEmpty)
                    return Center(
                      child: Text(
                        'No Data',
                        style: secondaryTextStyle(
                          weight: FontWeight.w600,
                          color: Colors.black.withAlpha(
                            (255 * 0.5).toInt(),
                          ),
                        ),
                      ),
                    );
                  return AnimatedListView(
                    itemCount: searchController.text.isNotEmpty
                        ? searchedTicketList.length
                        : _selectedFilter != TicketPayoutType.All
                            ? filteredList.length
                            : snap.data!.ticketData!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    emptyWidget: NoDataCustomWidget(title: "No Payouts available.", noData: AppImages.icNoData).paddingTop(60),
                    itemBuilder: (context, index) {
                      TicketData data = searchController.text.isNotEmpty
                          ? searchedTicketList[index]
                          : _selectedFilter != TicketPayoutType.All
                              ? filteredList[index]
                              : snap.data!.ticketData![index];
                      return TicketPayoutWidget(ticketData: data);
                    },
                  );
                }

                return snapWidgetHelper(snap, loadingWidget: aimLoader(context));
              },
            ),
            // if(Platform.isIOS) 16.height,
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption({required String label, required TicketPayoutType ticketPayoutType}) {
    return Row(
      children: [
        Radio<TicketPayoutType>(
          value: ticketPayoutType,
          groupValue: _selectedFilter,
          onChanged: (val) {
            setState(() {
              _selectedFilter = val!;
              setListAccordingToRadio();
            });
          },
        ),
        Text(label),
      ],
    );
  }
}
