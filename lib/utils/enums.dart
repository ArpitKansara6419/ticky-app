import 'dart:developer';

import 'package:flutter/foundation.dart';

enum jobType { PART_TIME, FULL_TIME }

enum genderType { MALE, FEMALE }

enum answerType { YES, NO }

enum accountType { PERSONAL, BUSINESS }

enum FileTypes { CANCEL, CAMERA, GALLERY }

enum AbLeaveType { PAID, UNPAID, MATERNITY }

enum TicketDayType { SameDay, StartingDay, MiddleDay, EndingDay, None }

enum FinishTaskType { HoldTask, EndTask }

enum PdfNavigation { Save, Clear, Cancel, None }

enum Language { English, Poland }

enum PdfType { Signed, Unsigned }

enum TicketPayoutType { All, Paid, Unpaid }

void mainLog({required String message, String? label}) {
  if (kDebugMode) {
    log(
      message,
      name: label ?? 'log',
    );
  }
}
