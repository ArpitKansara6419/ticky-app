import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';

String imageData(String address, double zoom) {
  final encodedAddress = Uri.encodeComponent(address);

  return "https://maps.googleapis.com/maps/api/staticmap?"
      "key=${Config.googleMapKey}&"
      "zoom=$zoom&"
      "size=300x100&"
      "maptype=roadmap&"
      "markers=color:red|label:L|$encodedAddress&"
      "center=$encodedAddress";
}

String getCurrentTime() {
  final DateTime now = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  );
  final DateFormat formatter = DateFormat(ShowDateFormat.hhMmSs);
  return formatter.format(now);
}

String getCurrentDate() {
  final DateTime now = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  );
  final DateFormat formatter = DateFormat(ShowDateFormat.yyyyMmDdDash);
  return formatter.format(now);
}

double calculateTotalPay({required TicketData ticketData, required TicketWorks data}) {
  double totalPay = ticketData.isAgreedRateForEngineer() ? ticketData.engineerAgreedRate.validate().toDouble() : data.hourlyPayable.validate().toDouble();

  // Overtime Pay (if approved)
  if (data.isOvertime.validate() == 1) {
    totalPay += data.overtimePayable.validate();
  }

  // Out of Office Hours Pay
  if (data.isOutOfOfficeHours.validate() == 1) {
    totalPay += data.out_of_office_payable.validate();
  }

  // Weekend Work Pay (from engineer's extra pay rate)
  if (data.isWeekend.validate() == 1) {
    totalPay += data.weekend_payable.validate();
  }

  // Holiday Work Pay (from engineer's extra pay rate)
  if (data.isHoliday.validate() == 1) {
    totalPay += data.holiday_payable.validate();
  }

  // Other Pay (if available)
  if (data.otherPay.validate() > 0) {
    totalPay += data.otherPay.validate().toDouble();
  }

  return totalPay;
}
