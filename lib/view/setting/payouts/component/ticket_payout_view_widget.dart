import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/functions.dart';
import 'package:ticky/view/tickets/functions.dart';

class TicketPayoutViewWidget extends StatelessWidget {
  final TicketWorks data;
  final TicketData ticketData;
  final int? index;

  const TicketPayoutViewWidget({super.key, required this.data, this.index, required this.ticketData});

  String getCurrencyValue({required num currencyValue}) {
    return ticketData.engineer!.payRates!.currencyType.validate().getCurrencyType() + currencyValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: radius(), color: context.scaffoldBackgroundColor),
      margin: const EdgeInsets.only(bottom: 4, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index != null) ...[
            Row(
              children: [
                Text("#${index.validate() + 1}", style: primaryTextStyle(size: 14)),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${formatDate(data.workStartDate.validate())}", style: primaryTextStyle(size: 12)),
                    Text("${formatTickyTime(data.startTime.validate())} - ${formatTickyTime(data.endTime.validate())}", style: primaryTextStyle(size: 12)),
                  ],
                ),
              ],
            ),
            8.height,
          ],
          Text("Payment Details:", style: boldTextStyle(size: 16)),
          12.height,
          Row(
            children: [
              Text("⏳ Total Work Time: ", style: primaryTextStyle(size: 12)),
              Spacer(),
              Text("${data.totalWorkTime.validate()}", style: boldTextStyle(size: 14)),
            ],
          ),
          if (ticketData.engineer != null && ticketData.engineer!.jobType != null && ticketData.engineer!.jobType!.isNotEmpty && ticketData.engineer!.jobType!.toLowerCase() == 'dispatch') ...[
            8.height,
            Row(
              children: [
                Text("⏳ Total Receivables:", style: primaryTextStyle(size: 12)),
                if (ticketData.isAgreedRateForEngineer()) Text(" (Agreed Rate)", style: boldTextStyle(size: 10, color: primaryColor)),
                Spacer(),
                Text(
                  getCurrencyValue(currencyValue: ticketData.isAgreedRateForEngineer() ? ticketData.engineerAgreedRate.validate() : data.hourlyPayable.validate()),
                  style: boldTextStyle(size: 14),
                ),
              ],
            ),
          ],
          if (data.isOutOfOfficeHours.validate() == 1) ...[
            8.height,
            Text("🌙 Out of Office Hours Details:", style: primaryTextStyle(size: 12)),
            2.height,
            Row(
              children: [
                16.width,
                Text("Out of Office Hours: (${getCurrencyValue(currencyValue: ticketData.engineer!.extraPayRates!.outOfOfficeHour.validate())})", style: primaryTextStyle(size: 12)),
                Spacer(),
                Text("${data.out_of_office_duration}", style: boldTextStyle(size: 14)),
              ],
            ),
            2.height,
            Row(
              children: [
                16.width,
                Text("Out of Office Hours Payable: ", style: primaryTextStyle(size: 12)),
                Spacer(),
                Text(getCurrencyValue(currencyValue: data.out_of_office_payable.validate()), style: boldTextStyle(size: 14)),
              ],
            ),
          ],
          if (data.isOvertime.validate() == 1) ...[
            8.height,
            Text("🕒 Overtime Details", style: primaryTextStyle(size: 12)),
            2.height,
            Row(
              children: [
                16.width,
                Text("Overtime Hour: ", style: primaryTextStyle(size: 12)),
                Spacer(),
                Text("${data.overtimeHour}", style: boldTextStyle(size: 14)),
              ],
            ),
            2.height,
            Row(
              children: [
                16.width,
                Text("Overtime Receivables: ", style: primaryTextStyle(size: 12)),
                Spacer(),
                Text(getCurrencyValue(currencyValue: data.overtimePayable.validate()), style: boldTextStyle(size: 14)),
              ],
            ),
          ],
          if (data.isWeekend.validate() == 1) ...[
            8.height,
            Row(
              children: [
                Text("📅 Weekend Work:", style: primaryTextStyle(size: 12)),
                Spacer(),
                Text("Yes (${getCurrencyValue(currencyValue: ticketData.isAgreedRateForEngineer() ? 0 : ticketData.engineer!.extraPayRates!.weekend.validate())})",
                    style: boldTextStyle(size: 14, color: Colors.green)),
              ],
            ),
          ],
          if (data.isHoliday.validate() == 1) ...[
            8.height,
            Row(
              children: [
                Text("🏝️ Holiday Work:", style: primaryTextStyle(size: 12)),
                Spacer(),
                Text("Yes (${getCurrencyValue(currencyValue: ticketData.isAgreedRateForEngineer() ? 0 : ticketData.engineer!.extraPayRates!.publicHoliday.validate())})",
                    style: boldTextStyle(size: 14, color: Colors.green)),
              ],
            ),
          ],
          if (data.otherPay.validate() > 0) ...[
            8.height,
            Row(
              children: [
                Text("➕ Other Pay:", style: primaryTextStyle(size: 12)),
                Spacer(),
                Text(
                  getCurrencyValue(currencyValue: ticketData.isAgreedRateForEngineer() ? 0 : data.otherPay.validate()),
                  style: boldTextStyle(size: 14, color: Colors.orange),
                ),
              ],
            ),
          ],
          Divider(thickness: 1, height: 20),
          Row(
            children: [
              Text("💰 Total Receivables:", style: primaryTextStyle(size: 16, weight: FontWeight.bold)),
              Spacer(),
              Text(
                getCurrencyValue(currencyValue: calculateTotalPay(data: data, ticketData: ticketData)),
                style: boldTextStyle(size: 16, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
