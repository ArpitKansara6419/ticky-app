import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:ticky/utils/enums.dart';

class LeaveDetails {
  const LeaveDetails({
    required this.todayDate,
    required this.employeeName,
    required this.employerName,
    required this.day,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.position,
    this.employeeSignature,
    this.employerSignature,
    this.addressOne,
    this.addressTwo,
  });

  final String todayDate;
  final String employeeName;
  final String employerName;
  final String day;
  final String startDate;
  final String endDate;
  final String reason;
  final String? position;
  final String? addressOne;
  final String? addressTwo;
  final Uint8List? employeeSignature;
  final Uint8List? employerSignature;

  Map<String, dynamic> toJson() {
    return {
      'todayDate': todayDate,
      'employeeName': employeeName,
      'employerName': employerName,
      'day': day,
      'startDate': startDate,
      'endDate': endDate,
      'reason': reason,
      'position': position,
      'addressOne': addressOne,
      'addressTwo': addressTwo,
      'employeeSignature': employeeSignature != null ? base64Encode(employeeSignature!) : null,
      'employerSignature': employerSignature != null ? base64Encode(employerSignature!) : null,
    };
  }
}

class StringsForPdfInMultiLanguage {
  /// Employee Name
  static final String employeeNamePolish = 'Imię i nazwisko pracownika';

  /// Place, Date
  static final String placeDatePolish = 'Miejsce, Data';

  /// Employer Name
  static final String employerNamePolish = 'Nazwa pracodawcy';

  /// Application For Unpaid Leave
  static final String applicationForUnpaidLeavePolish = 'Wniosek o urlop bezpłatny';

  /// Reason
  static final String reasonPolish = 'Powód';

  /// Legal Basis
  static final String legalBasisPolish = 'Podstawa prawna: Artykuł 174 § 1 Kodeksu pracy';

  /// Employer Signature
  static final String employerSignaturePolish = 'Podpis pracodawcy';

  /// Employee Signature
  static final String employeeSignaturePolish = 'Podpis pracownika';

  /// Surname, Name
  static final String surnameNamePolish = 'Nazwisko, Imię';

  /// Position
  static final String positionPolish = 'Stanowisko';

  /// Employer Details
  static final String employerDetailsPolish = 'Dane pracodawcy';

  /// Application For Holiday Leave
  static final String applicationForHolidayLeavePolish = 'Wniosek o urlop wypoczynkowy';

  /// Leave Request Statement
  static String leaveRequestStatementPolish({
    required String day,
    required String startDate,
    required String endDate,
  }) =>
      'Zwracam się z prośbą o udzielenie mi $day dni urlopu bezpłatnego od ${day == '1' && startDate == endDate ? startDate : '$startDate do $endDate'}.';

  /// Leave Request Statement - paid

  static String leaveRequestHolidayStatementPolish({
    required String day,
    required String startDate,
    required String endDate,
  }) =>
      'Zwracam się z prośbą o udzielenie mi $day dni urlopu wypoczynkowego od ${day == '1' && startDate == endDate ? startDate : '$startDate do $endDate'}.';
}

class PdfComponents {
  static String? unpaidPdfPath;
  static String? unpaidSignedPdfPath;
  static String? paidPdfPath;
  static String? paidSignedPdfPath;

  static Future<void> unpaidLeavePDF({
    required BuildContext context,
    required PdfType pdfType,
    required LeaveDetails leaveDetails,
  }) async {
    await getApplicationDocumentsDirectory().then((value) {
      log('value => ${value.path}');
      unpaidPdfPath = value.path + '/unpaid_pdf_leave.pdf';
      unpaidSignedPdfPath = value.path + '/unpaid_signed_pdf_leave.pdf';
    });

    log('unpaidPdfPath => $unpaidPdfPath');
    log('unpaidSignedPdfPath => $unpaidSignedPdfPath');
    log('leaveDetails => ${jsonEncode(leaveDetails.toJson())}');

    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;

    // Standard A4 dimensions
    double pageWidth = graphics.clientSize.width;
    double leftMargin = 0;
    double rightMargin = pageWidth - 180;
    double centerMargin = pageWidth / 4;
    double yPosition = 40;

    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 14);
    final PdfFont subtitleFont = PdfStandardFont(PdfFontFamily.helvetica, 12);
    final PdfFont titleFont = PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold);

    // Signatures
    final PdfBitmap? employeeSignature = leaveDetails.employeeSignature != null ? PdfBitmap(leaveDetails.employeeSignature!) : null;
    final PdfBitmap? employerSignature = leaveDetails.employerSignature != null ? PdfBitmap(leaveDetails.employerSignature!) : null;

    // Employee Name
    graphics.drawString(leaveDetails.employeeName, font, bounds: Rect.fromLTWH(leftMargin, yPosition, pageWidth, 20));
    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(leftMargin, yPosition + 3, pageWidth, 20));
    graphics.drawString("(${StringsForPdfInMultiLanguage.employeeNamePolish})", subtitleFont, bounds: Rect.fromLTWH(leftMargin + 26, yPosition + 20, pageWidth, 20));

    // Place & Date
    graphics.drawString(leaveDetails.todayDate, font, bounds: Rect.fromLTWH(rightMargin, yPosition, pageWidth, 20));
    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(rightMargin, yPosition + 3, pageWidth, 20));
    graphics.drawString("(${StringsForPdfInMultiLanguage.placeDatePolish})", subtitleFont, bounds: Rect.fromLTWH(rightMargin + 26, yPosition + 20, pageWidth, 20));

    yPosition += 80;

    // Employer Name
    graphics.drawString(leaveDetails.employerName, font, bounds: Rect.fromLTWH(rightMargin, yPosition, pageWidth, 20));
    graphics.drawString(leaveDetails.addressOne ?? "_____________________", font, bounds: Rect.fromLTWH(rightMargin, yPosition + 20, pageWidth, 20));
    graphics.drawString(leaveDetails.addressTwo ?? "_____________________", font, bounds: Rect.fromLTWH(rightMargin, yPosition + 40, pageWidth, 20));
    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(rightMargin, yPosition + 50, pageWidth, 20));
    graphics.drawString("(${StringsForPdfInMultiLanguage.employerNamePolish})", subtitleFont, bounds: Rect.fromLTWH(rightMargin + 26, yPosition + 70, pageWidth, 20));

    yPosition += 150;

    // Title
    graphics.drawString("${StringsForPdfInMultiLanguage.applicationForUnpaidLeavePolish}", titleFont, bounds: Rect.fromLTWH(centerMargin, yPosition, pageWidth + 100, 100));
    yPosition += 40;

    // Leave Request Details
    graphics.drawString(
      StringsForPdfInMultiLanguage.leaveRequestStatementPolish(day: leaveDetails.day, startDate: leaveDetails.startDate, endDate: leaveDetails.endDate),
      font,
      bounds: Rect.fromLTWH(leftMargin, yPosition, pageWidth - 40, 80),
    );

    if (leaveDetails.reason.isNotEmpty) {
      yPosition += 50;
      graphics.drawString("${StringsForPdfInMultiLanguage.reasonPolish}: ${leaveDetails.reason}", font, bounds: Rect.fromLTWH(leftMargin, yPosition, pageWidth - 40, 80));
    }

    yPosition += 100;

    // Legal Basis
    graphics.drawString(StringsForPdfInMultiLanguage.legalBasisPolish, font, bounds: Rect.fromLTWH(leftMargin, yPosition, pageWidth, 20));

    yPosition += 200;

    // Signatures
    if (employerSignature != null && pdfType == PdfType.Signed) {
      graphics.drawImage(employerSignature, Rect.fromLTWH(leftMargin, yPosition - 50, 200, 100));
    }

    if (employeeSignature != null) {
      graphics.drawImage(employeeSignature, Rect.fromLTWH(rightMargin, yPosition - 60, 150, 100));
    }

    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(rightMargin, yPosition, pageWidth, 20));
    graphics.drawString("(${StringsForPdfInMultiLanguage.employeeSignaturePolish})", subtitleFont, bounds: Rect.fromLTWH(rightMargin + 26, yPosition + 20, pageWidth, 20));

    // Save PDF
    if (pdfType == PdfType.Signed) {
      await File(unpaidSignedPdfPath!).writeAsBytes(await document.save());
    } else {
      await File(unpaidPdfPath!).writeAsBytes(await document.save());
    }
  }

  static Future<void> paidLeavePDF({
    required BuildContext context,
    required PdfType pdfType,
    required LeaveDetails leaveDetails,
    GlobalKey<SfSignaturePadState>? signaturePadKey,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    paidPdfPath = '${dir.path}/paid_pdf_leave.pdf';
    paidSignedPdfPath = '${dir.path}/paid_signed_pdf_leave.pdf';

    log('paidPdfPath => $paidPdfPath');
    log('paidSignedPdfPath => $paidSignedPdfPath');
    log('leaveDetails => ${jsonEncode(leaveDetails.toJson())}');

    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;

    final double pageWidth = graphics.clientSize.width;

    const double sidePadding = 8;
    const double lineHeight = 22;
    const double sectionSpacing = 40;

    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 14);
    final PdfFont bodyFont = PdfStandardFont(PdfFontFamily.helvetica, 16);
    final PdfFont subtitleFont = PdfStandardFont(PdfFontFamily.helvetica, 12);
    final PdfFont titleFont = PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold);

    final PdfBitmap? employeeSignature = leaveDetails.employeeSignature != null ? PdfBitmap(leaveDetails.employeeSignature!) : null;
    final PdfBitmap? employerSignature = leaveDetails.employerSignature != null ? PdfBitmap(leaveDetails.employerSignature!) : null;

    double y = 40;

    /// Draw Name, Date, Position, Employer Details
    y = drawCenteredFieldsSection(
      graphics: graphics,
      pageWidth: pageWidth,
      pageHeight: graphics.clientSize.height,
      font: font,
      subtitleFont: subtitleFont,
      sidePadding: sidePadding,
      sectionSpacing: sectionSpacing,
      leaveDetails: leaveDetails,
      startY: y,
    );

    /// Title
    graphics.drawString(
      StringsForPdfInMultiLanguage.applicationForHolidayLeavePolish,
      titleFont,
      bounds: Rect.fromLTWH((pageWidth - 300) / 2, y, 300, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );

    y += 50;

    /// Leave Request Statement
    graphics.drawString(
      StringsForPdfInMultiLanguage.leaveRequestHolidayStatementPolish(
        day: leaveDetails.day,
        startDate: leaveDetails.startDate,
        endDate: leaveDetails.endDate,
      ),
      bodyFont,
      bounds: Rect.fromLTWH(sidePadding, y, pageWidth - sidePadding * 2, 80),
      format: PdfStringFormat(lineSpacing: 10),
    );

    y += 150;

    /// Signatures
    if (pdfType == PdfType.Signed && employerSignature != null) {
      graphics.drawImage(employerSignature, Rect.fromLTWH(sidePadding, y - 50, 150, 80));
    }

    if (employeeSignature != null) {
      graphics.drawImage(employeeSignature, Rect.fromLTWH(pageWidth - 180, y - 60, 130, 80));
    }

    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(pageWidth - 180, y, pageWidth, lineHeight));
    graphics.drawString(
      "(${StringsForPdfInMultiLanguage.employeeSignaturePolish})",
      subtitleFont,
      bounds: Rect.fromLTWH(pageWidth - 180 + 26, y + 20, pageWidth, lineHeight),
    );

    /// Save PDF
    final outputPath = pdfType == PdfType.Signed ? paidSignedPdfPath : paidPdfPath;
    await File(outputPath!).writeAsBytes(await document.save());
  }

  static double drawCenteredFieldsSection({
    required PdfGraphics graphics,
    required double pageWidth,
    required double pageHeight,
    required PdfFont font,
    required PdfFont subtitleFont,
    required double sidePadding,
    required double sectionSpacing,
    required LeaveDetails leaveDetails,
    required double startY,
  }) {
    double y = startY;
    final double leftColumnWidth = pageWidth / 2 - 40;
    final double rightColumnWidth = pageWidth / 2 - 40;
    // Surname & Name
    graphics.drawString(leaveDetails.employeeName, font, bounds: Rect.fromLTWH(sidePadding + 36, y, leftColumnWidth, 22));
    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(sidePadding, y + 3, leftColumnWidth, 22));
    graphics.drawString(
      "(${StringsForPdfInMultiLanguage.surnameNamePolish})",
      subtitleFont,
      bounds: Rect.fromLTWH(sidePadding + 36, y + 20, leftColumnWidth, 22),
    );

    // Place & Date
    graphics.drawString(leaveDetails.todayDate, font, bounds: Rect.fromLTWH(pageWidth - 180 + 36, y, rightColumnWidth, 22));
    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(pageWidth - 180, y + 3, rightColumnWidth, 22));
    graphics.drawString(
      "(${StringsForPdfInMultiLanguage.placeDatePolish})",
      subtitleFont,
      bounds: Rect.fromLTWH(pageWidth - 180 + 36, y + 20, rightColumnWidth, 22),
    );

    y += sectionSpacing + 20;

    // Position
    graphics.drawString(leaveDetails.position.validate(), font, bounds: Rect.fromLTWH(sidePadding + 36, y, pageWidth, 22));
    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(sidePadding, y + 3, pageWidth, 22));
    graphics.drawString(
      "(${StringsForPdfInMultiLanguage.positionPolish})",
      subtitleFont,
      bounds: Rect.fromLTWH(sidePadding + 40, y + 20, pageWidth, 22),
    );

    y += sectionSpacing + 20;

    // Employer Details
    final double employerStartX = pageWidth - 200;
    graphics.drawString(leaveDetails.employerName, font, bounds: Rect.fromLTWH(employerStartX, y, pageWidth, 22));
    graphics.drawString(leaveDetails.addressOne ?? "_____________________", font, bounds: Rect.fromLTWH(employerStartX, y + 20, pageWidth, 22));
    graphics.drawString(leaveDetails.addressTwo ?? "_____________________", font, bounds: Rect.fromLTWH(employerStartX, y + 40, pageWidth, 22));
    graphics.drawString("_____________________", font, bounds: Rect.fromLTWH(employerStartX, y + 60, pageWidth, 22));
    graphics.drawString(
      "(${StringsForPdfInMultiLanguage.employerDetailsPolish})",
      subtitleFont,
      bounds: Rect.fromLTWH(employerStartX + 26, y + 80, pageWidth, 22),
    );

    return y + 150;
  }

  static Widget signaturePad({
    required GlobalKey<SfSignaturePadState> signaturePadKey,
    required void Function(ui.Image image) onDrawEnd,
    required double height,
  }) {
    return SfSignaturePad(
      backgroundColor: Colors.white,
      strokeColor: Colors.black,
      key: signaturePadKey,
      onDrawEnd: () async {
        ui.Image image = await signaturePadKey.currentState!.toImage();
        onDrawEnd(image);
      },
    );
  }
}
