import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/imports.dart';

import 'date_utils.dart';

InputDecoration inputDecoration({
  String? hint,
  Widget? prefixIcon,
  String? svgImage,
  Color? svgIconColor,
  IconButton? suffixIcon,
}) {
  var border = OutlineInputBorder(
    borderRadius: radius(),
    borderSide: BorderSide(color: borderColor, width: 1),
  );

  return InputDecoration(
    hintText: hint ?? "Input Here...",
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    hintStyle: secondaryTextStyle(size: 12),
    prefixIcon: prefixIcon,
    border: border,
    focusedBorder: border,
    disabledBorder: border,
    suffixIcon: suffixIcon,
    errorBorder: OutlineInputBorder(
      borderRadius: radius(),
      borderSide: BorderSide(color: redColor, width: 0.6),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(),
      borderSide: BorderSide(color: redColor, width: 0.6),
    ),
    counter: Offstage(),
    enabledBorder: border,
  );
}

BoxDecoration cardBoxDecoration(BuildContext context) {
  return BoxDecoration(borderRadius: radius(), color: context.theme.colorScheme.surfaceContainerLow);
}

class SharePreferencesKey {
  static String loggedIn = "loggedIn";
  static String firstName = "firstName";
  static String lastName = "lastName";
  static String email = "email";
  static String phoneNumber = "phoneNumber";
  static String countryCodeNumber = "countryCodeNumber";
  static String profileImage = "profileImage";
  static String accessToken = "accessToken";
  static String emailVerified = "emailVerified";
  static String phoneNumberVerified = "phoneNumberVerified";
  static String currencyCode = "currencyCode";
  static String userId = "userId";
  static String jobType = "jobType";
  static String jobTitle = "jobTitle";
  static String checkInTime = "checkInTime";
  static String checkOutTime = "checkOutTime";
  static String clockIn = "clockIn";
  static String startWorkTime = "startWorkTime";
  static String startIsTaskWork = "startIsTaskWork";
  static String gdprConsent = "gdprConsent";
  static String isRemember = "isRemember";
  static String firebaseToken = "firebaseToken";
  static String contactISO = "contactISO";
  static String countryCode = "countryCode";
}

class RunningTasks {
  RunningTasks({required this.timerPeriodic, required this.ticketData});

  final Timer timerPeriodic;
  final TicketData ticketData;

  RunningTasks copyWith({Timer? timerPeriodic, TicketData? ticketData}) {
    return RunningTasks(
      timerPeriodic: timerPeriodic ?? this.timerPeriodic,
      ticketData: ticketData ?? this.ticketData,
    );
  }

  Map<String, dynamic> toJsonForPrinting() {
    return {
      'isActive': timerPeriodic.isActive,
      'tick': timerPeriodic.tick,
      'ticketData': ticketData.toJson(),
    };
  }
}

class ListItemWidget extends StatelessWidget {
  final Widget child;
  final Function() onTap;

  ListItemWidget({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius(),
        child: Container(
          decoration: BoxDecoration(borderRadius: radius(), color: Colors.white),
          child: child,
        ),
      ),
    );
  }
}

String getFileTypeImage(String fileName) {
  // Determine the file extension
  final extension = fileName.split('.').last.toLowerCase();

  // Map file types to their respective image assets or icons
  switch (extension) {
    case 'jpg':
      return AppFiles.icJpg;
    case 'jpeg':
      return AppFiles.icJpg;
    case 'png':
      return AppFiles.icPng;
    case 'gif':
      return AppFiles.icPng;
    case 'bmp':
      return AppFiles.icBmp;
    case 'pdf':
      return AppFiles.icPdf;

    case 'doc':
      return AppFiles.icDoc;
    case 'docx':
      return AppFiles.icDocx;

    case 'xls':
      return AppFiles.icXsl;
    case 'xlsx':
      return AppFiles.icXsl;

    default:
      return AppFiles.icBmp;
  }
}

String daysToGo(DateTime targetDate) {
  final DateTime today = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  );
  final int difference = targetDate.difference(today).inDays;

  if (difference == 0) {
    return 'Today';
  } else if (difference == 1) {
    return 'Tomorrow';
  } else {
    return '$difference days to go';
  }
}

String formatDate(
  String dateString, {
  String outputFormat = ShowDateFormat.ddMmmYyyy,
  List<String> inputPossibleFormats = const [],
}) {
  if (dateString.isEmpty) {
    // Optionally, log this event if it's unexpected in your workflow
    // log('Input dateString is empty.');
    return "";
  }

  DateTime? parsedDateTime;

  // 1. Try DateTime.parse() first for ISO 8601 compliance and flexibility
  try {
    parsedDateTime = DateTime.parse(dateString);
    // If the input was ISO 8601 UTC (ends with 'Z') and output is not UTC, convert to local.
    if (dateString.endsWith('Z') && !outputFormat.endsWith('Z')) {
      parsedDateTime = parsedDateTime.toLocal();
    }
  } catch (e) {
    // DateTime.parse failed, now try custom formats

    // Prepare the list of formats to try: user-provided first, then defaults.
    List<String> formatsToTry = List.from(inputPossibleFormats);

    // Add default formats, ensuring no duplicates if already in inputPossibleFormats
    final defaultFallbackFormats = [
      ShowDateFormat.dateTimeIso, // Must be tried early if DateTime.parse failed (e.g. no sub-seconds)
      ShowDateFormat.dateTimeIsoLocal,
      ShowDateFormat.dateTimeApi,
      ShowDateFormat.mmDdYyyySlashHhMmSs,
      ShowDateFormat.ddMmYyyySlashHhMmSs,
      ShowDateFormat.yyyyMmDdDotHhMmSs,
      ShowDateFormat.ddMmYyyyDotHhMmSs,
      ShowDateFormat.apiCallingDate,
      ShowDateFormat.mmDdYyyySlash,
      ShowDateFormat.ddMmYyyySlash,
      ShowDateFormat.yyyyMmDdDot,
      ShowDateFormat.ddMmYyyyDot,
    ];

    for (var fmt in defaultFallbackFormats) {
      if (!formatsToTry.contains(fmt)) {
        formatsToTry.add(fmt);
      }
    }
    // Optional: make unique again in case inputPossibleFormats had overlaps with defaults,
    // though the above check already prevents direct duplicates from defaultFallbackFormats.
    // formatsToTry = formatsToTry.toSet().toList();

    for (String formatPattern in formatsToTry) {
      try {
        parsedDateTime = DateFormat(formatPattern).parseStrict(dateString);
        // If the format pattern implies UTC (e.g., ends with 'Z') and output is not UTC, convert.
        if (formatPattern.endsWith('Z') && !outputFormat.endsWith('Z') && parsedDateTime != null) {
          parsedDateTime = parsedDateTime.toLocal();
        }
        break; // Successfully parsed
      } catch (fe) {
        // Try the next format
      }
    }
  }

  // 2. If parsing was successful
  if (parsedDateTime != null) {
    try {
      return DateFormat(outputFormat).format(parsedDateTime);
    } catch (formatError) {
      log('Error applying outputFormat "$outputFormat" to parsed DateTime for input "$dateString": $formatError');
      return dateString; // Fallback to original string if output formatting fails
    }
  } else {
    // 3. If all parsing attempts fail
    log('Could not parse dateString "$dateString" with any of the attempted formats.');
    return dateString; // Fallback to original string
  }
}

/// Formats a date-time string or a time-only string into a custom time output format.
///
/// This function attempts to parse the [rawTime] input by:
/// 1. Trying `DateTime.parse()` for full ISO 8601 date-time strings.
///    If the string ends with 'Z' (UTC), it's converted to local time.
/// 2. If `DateTime.parse()` fails, it tries to parse [rawTime] as a time-only string
///    using the formats provided in [timeOnlyInputFormats] or common defaults.
///
/// - [rawTime]: The input string, which can be a full date-time (e.g., ISO 8601)
///   or a time-only string (e.g., "14:30:00").
/// - [outputFormat]: The desired time output format string (e.g., `ShowDateFormat.hhMm`,
///   `ShowDateFormat.hhMm12`). Defaults to `ShowDateFormat.hhMm`.
/// - [timeOnlyInputFormats]: An optional list of specific time-only input format strings
///   to try if [rawTime] is not a full date-time string. Defaults include "HH:mm:ss" and "HH:mm".
///
/// Returns the formatted time string, or the original [rawTime] if all parsing and formatting attempts fail.
String formatTickyTime(
  String rawTime, {
  String outputFormat = ShowDateFormat.hhMm, // Default to 24-hour HH:mm
  List<String> timeOnlyInputFormats = const [
    ShowDateFormat.hhMmSs, // "HH:mm:ss"
    ShowDateFormat.hhMm, // "HH:mm"
    ShowDateFormat.apiCallingTime // Equivalent to hhMmSs, good for clarity
  ],
}) {
  if (rawTime.isEmpty) {
    log('Input rawTime is empty.');
    return "";
  }

  DateTime? dateTimeToFormat;

  // 1. Try to parse as a full ISO 8601 DateTime string first
  try {
    dateTimeToFormat = DateTime.parse(rawTime);
    // If successful, rawTime was a full timestamp.
    // Convert UTC to local time for display if necessary.
    if (rawTime.endsWith('Z')) {
      dateTimeToFormat = dateTimeToFormat.toLocal();
    }
  } catch (e) {
    // If DateTime.parse fails, it's not a standard full timestamp.
    // So, now try parsing it as a time-only string.

    // Ensure no duplicates in the list of formats to try for time-only strings
    final List<String> uniqueTimeOnlyFormats = timeOnlyInputFormats.toSet().toList();

    for (String format in uniqueTimeOnlyFormats) {
      try {
        // DateFormat.parse on a time-only string gives a DateTime object
        // with a default date (1970-01-01) but correct time components.
        dateTimeToFormat = DateFormat(format).parseStrict(rawTime);
        // No need to adjust to today's date if only formatting time components (HH:mm, etc.)
        break; // Successfully parsed as a time-only string
      } catch (fe) {
        // Continue to the next format in timeOnlyInputFormats
      }
    }
  }

  // 2. If parsing was successful (either as full DateTime or time-only)
  if (dateTimeToFormat != null) {
    try {
      return DateFormat(outputFormat).format(dateTimeToFormat);
    } catch (formatError) {
      log('Error applying outputFormat "$outputFormat" to parsed DateTime for input "$rawTime": $formatError');
      return rawTime; // Fallback to rawTime if output formatting fails
    }
  } else {
    // 3. If all parsing attempts fail
    log('Could not parse rawTime "$rawTime" as DateTime or any of the time-only formats: $timeOnlyInputFormats');
    return rawTime; // Fallback to rawTime
  }
}

int calculateTotalLeaveDays(String fromDate, String toDate) {
  // Parse the string dates into DateTime objects
  DateTime from = DateFormat(ShowDateFormat.yyyyMmDdDash).parse(fromDate);
  DateTime to = DateFormat(ShowDateFormat.yyyyMmDdDash).parse(toDate);

  // Calculate the difference in days
  int totalDays = to.difference(from).inDays;

  // Return the total number of leave days
  return totalDays >= 0 ? totalDays + 1 : 0; // +1 to include the 'from' day itself
}

/// Function to calculate the time difference and return it as a string
String calculateTimeDifferenceAsString(String startTime, String endTime) {
  if (endTime.validate().isEmpty) return "--";
  try {
    // Parse the start and end time into Duration objects
    List<String> startParts = startTime.split(':');
    List<String> endParts = endTime.split(':');

    if (startParts.length < 3 || endParts.length < 3) {
      throw FormatException('Invalid time format. Use HH:MM:SS.');
    }

    // Convert start and end times to Duration
    Duration startDuration = Duration(
      hours: int.parse(startParts[0]),
      minutes: int.parse(startParts[1]),
      seconds: int.parse(startParts[2]),
    );

    Duration endDuration = Duration(
      hours: int.parse(endParts[0]),
      minutes: int.parse(endParts[1]),
      seconds: int.parse(endParts[2]),
    );

    // Calculate the difference
    Duration difference = endDuration - startDuration;

    if (difference.isNegative) {
      throw Exception('End time must be after start time.');
    }

    // Format the difference as HH:MM:SS
    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  } catch (e) {
    return '00:00:00';
  }
}

String maskEmail(String email) {
  // Find the index of '@' symbol
  int atIndex = email.indexOf('@');

  if (atIndex > 0) {
    // Mask the email, keeping the first letter, and the last 3 letters of the local part
    String localPart = email.substring(0, atIndex);
    String domainPart = email.substring(atIndex);

    // Mask the local part except the first letter and the last 3 characters
    String maskedLocalPart = localPart[0] + '*' * (localPart.length - 4) + localPart.substring(localPart.length - 3);

    return maskedLocalPart + domainPart;
  }

  // Return the original email if '@' symbol is not found
  return email;
}

List<DateTime> getBlackoutDates(DateTime startDate, DateTime endDate) {
  List<DateTime> blackoutDates = [];

  // Loop through each date in the range from startDate to endDate
  for (var date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(Duration(days: 1))) {
    // Check if the day is Saturday or Sunday
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      blackoutDates.add(date);
    }
  }

  return blackoutDates;
}

String? daysLeftForExpiry(String expiryDateString) {
  try {
    // Parse the input date string
    DateTime expiryDate = DateFormat(ShowDateFormat.yyyyMmDdDash).parse(expiryDateString);
    DateTime currentDate = DateTimeUtils.convertDateTimeToUTC(
      dateTime: DateTime.now(),
    );

    // Calculate the difference in days
    int daysLeft = expiryDate.difference(currentDate).inDays;

    if (daysLeft <= 0) {
      return "Expired.";
    } else if (daysLeft <= 30) {
      return "Expiring in $daysLeft days!";
    } else {
      return null;
    }
  } catch (e) {
    return "Invalid date format. Please use ${ShowDateFormat.yyyyMmDdDash}.";
  }
}

dynamic digitalSignatureInBottomSheet({
  required BuildContext context,
  required String title,
  required GlobalKey<SfSignaturePadState> signatureKey,
  required void Function(Uint8List signatureData) onSave,
  double? maxHeightRatio,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    scrollControlDisabledMaxHeightRatio: maxHeightRatio ?? 0.5,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: SfSignaturePad(
                key: signatureKey,
                backgroundColor: Colors.white,
                strokeColor: Colors.black,
                minimumStrokeWidth: 1.0,
                maximumStrokeWidth: 4.0,
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      signatureKey.currentState?.clear();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    label: Text("Clear"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final RenderSignaturePad? renderSignaturePad = signatureKey.currentContext?.findRenderObject() as RenderSignaturePad?;

                      Uint8List? localUint8List;
                      ui.Image? uiImage;

                      if (renderSignaturePad != null) {
                        uiImage = await renderSignaturePad.toImage(pixelRatio: 3.0);
                        final ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
                        localUint8List = byteData?.buffer.asUint8List();
                      }
                      if (localUint8List != null) {
                        onSave(localUint8List);
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      );
    },
  );
}

extension stringExt on String {
  String getCurrencyType() {
    switch (this) {
      case "dollar":
        return "\$";
      case "euro":
        return "€";
      case "pound":
        return "£";
      case "PLN":
        return "zł";
      default:
        return "zł";
    }
  }

  String getJobType() {
    switch (this) {
      case "full_time":
        return "Full Time";
      case "part_time":
        return "Part Time";
      case "dispatch":
        return "Dispatch";
      default:
        return "Dispatch";
    }
  }
}
