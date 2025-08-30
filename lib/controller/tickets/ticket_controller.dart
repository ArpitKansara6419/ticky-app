import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/login_response.dart';
import 'package:ticky/model/engineer/documents/add_document_response.dart';
import 'package:ticky/model/tickets/break_data.dart';
import 'package:ticky/model/tickets/calendar_ticket_response.dart';
import 'package:ticky/model/tickets/ticket_response.dart';
import 'package:ticky/model/tickets/ticket_work_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/enums.dart';

class TicketController {
  static Future<TicketListResponse> getTicketListApi({
    String? engineer_status,
    String? status,
    String? extraStatus,
    int? month,
    int? year,
  }) async {
    Map request = {
      "engineer_id": "${userStore.userId.validate()}",
    };

    if (engineer_status != null) {
      request.putIfAbsent("engineer_status", () => engineer_status);
    }
    if (status != null) {
      request.putIfAbsent("status", () => extraStatus != null ? [status, extraStatus] : [status]);
    }
    String monthPara = month != null ? "&month=$month" : "";
    String yearPara = month != null ? "?year=$year" : "";

    return TicketListResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.ticketsListUrl + yearPara + monthPara, method: HttpMethod.POST, request: request)));
  }

  static Future<CalendarTicketResponse> getCalendarTicketListApi({required DateTime date}) async {
    // Calculate the start and end dates of the month for the given date
    DateTime startDate = DateTime(date.year, date.month, 1); // First day of the month
    DateTime endDate = DateTime(date.year, date.month + 1, 0); // Last day of the month

    // Format the dates
    String formattedStartDate = formatClockInDateTime(startDate, format: "yyyy-MM-dd");
    String formattedEndDate = formatClockInDateTime(endDate, format: "yyyy-MM-dd");

    // Make the API call
    return CalendarTicketResponse.fromJson(
      await handleResponse(
        await buildHttpResponse(
          "${TicketsEndPoints.calendarTicketsListUrl}/${userStore.userId}/$formattedStartDate/$formattedEndDate",
          method: HttpMethod.GET,
        ),
      ),
    );
  }

  static Future<void> ticketStatusApi({Map<String, dynamic>? req}) async {
    var data = await handleResponse(await buildHttpResponse(TicketsEndPoints.updateTicketStatusApi, method: HttpMethod.POST, request: req));
    print(data);
  }

  static Future<TicketWorkResponse> ticketDetail({required int ticketId}) async {
    return TicketWorkResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.ticketDetailStatusApi + "/${ticketId}")));
  }

  static Future<TicketWorkResponse> ticketWorkStatus({required int ticketNumber}) async {
    return TicketWorkResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.ticketWorkStatus + "?ticket_id=$ticketNumber", method: HttpMethod.GET)));
  }

  static Future<TicketWorkResponse> startWorkApi({Map<String, dynamic>? req}) async {
    return TicketWorkResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.startWork, method: HttpMethod.POST, request: req)));
  }

  static Future<TicketWorkResponse> endWorkApi({Map<String, dynamic>? req}) async {
    return TicketWorkResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.endWork, method: HttpMethod.POST, request: req)));
  }

  static Future<TicketWorkResponse> addTicketBreakApi({Map<String, dynamic>? req}) async {
    return TicketWorkResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.addTicketBreak, method: HttpMethod.POST, request: req)));
  }

  static Future<BreakResponse> endTicketBreakApi({Map<String, dynamic>? req}) async {
    return BreakResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.endTicketBreak, method: HttpMethod.POST, request: req)));
  }

  static Future<AddDocumentResponse> saveNotesApiMultipart({
    required Map<String, dynamic> req,
    List<File>? files,
    bool isUpdate = false,
  }) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(TicketsEndPoints.addNote);

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: true);

    req.forEach((key, value) {
      multiPartRequest.fields[key] = value.toString();
    });

    if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
      await Future.forEach<File>(files!, (element) async {
        multiPartRequest.files.add(await MultipartFile.fromPath("documents" + '[${files.indexOf(element)}]', element.path));
      });
    }

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.length}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: false);
        AddDocumentResponse res = AddDocumentResponse.fromJson(jsonDecode(data));

        toast(res.message.validate(), print: true);
        finish(getContext, true);
      },
      onError: (error) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: false);
        toast(error.toString(), print: true);
      },
    );

    return AddDocumentResponse();
  }

  static Future<AddDocumentResponse> deleteNotesApiMultipart({
    required int id,
  }) async {
    LogoutResponse res = LogoutResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.deleteNote + id.toString(), method: HttpMethod.DELETE)));
    mainLog(
      message: jsonEncode(res.toJson()),
      label: 'res.toJson() => ',
    );
    // AddDocumentResponse addDocumentResponse = await deel(TicketsEndPoints.addNote, req: {});
    //
    // appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: true);
    //
    // req.forEach((key, value) {
    //   multiPartRequest.fields[key] = value.toString();
    // });
    //
    // if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
    //   await Future.forEach<File>(files!, (element) async {
    //     multiPartRequest.files.add(await MultipartFile.fromPath("documents" + '[${files.indexOf(element)}]', element.path));
    //   });
    // }
    //
    // log("Request ${multiPartRequest.fields}");
    // log("Request ${multiPartRequest.files.length}");
    //
    // multiPartRequest.headers.addAll(buildHeaderTokens());
    //
    // sendMultiPartRequest(
    //   multiPartRequest,
    //   onSuccess: (data) async {
    //     appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: false);
    //     AddDocumentResponse res = AddDocumentResponse.fromJson(jsonDecode(data));
    //
    //     toast(res.message.validate(), print: true);
    //     finish(getContext, true);
    //   },
    //   onError: (error) {
    //     appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: false);
    //     toast(error.toString(), print: true);
    //   },
    // );

    return AddDocumentResponse();
  }

  static Future<AddDocumentResponse> saveFoodExpenseMultipart({required Map<String, dynamic> req, List<File>? files}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(TicketsEndPoints.foodExpense);

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.foodExpenseApiState, value: true);

    req.forEach((key, value) {
      multiPartRequest.fields[key] = value.toString();
    });

    if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
      await Future.forEach<File>(files!, (element) async {
        multiPartRequest.files.add(await MultipartFile.fromPath("document", element.path));
        // multiPartRequest.files.add(await MultipartFile.fromPath("documents" + '[${files.indexOf(element)}]', element.path));
      });
    }

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.map((e) => e.field + "==========>" + e.filename.validate())}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.foodExpenseApiState, value: false);
        AddDocumentResponse res = AddDocumentResponse.fromJson(jsonDecode(data));

        toast(res.message.validate(), print: true);
        finish(getContext, true);
      },
      onError: (error) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.foodExpenseApiState, value: false);
        toast(error.toString(), print: true);
      },
    );

    return AddDocumentResponse();
  }

  static Future<AddDocumentResponse> deleteFoodExpense({
    required int id,
  }) async {
    LogoutResponse res = LogoutResponse.fromJson(await handleResponse(await buildHttpResponse(TicketsEndPoints.deleteFoodExpense + id.toString(), method: HttpMethod.DELETE)));
    mainLog(
      message: jsonEncode(res.toJson()),
      label: 'res.toJson() => ',
    );
    // AddDocumentResponse addDocumentResponse = await deel(TicketsEndPoints.addNote, req: {});
    //
    // appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: true);
    //
    // req.forEach((key, value) {
    //   multiPartRequest.fields[key] = value.toString();
    // });
    //
    // if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
    //   await Future.forEach<File>(files!, (element) async {
    //     multiPartRequest.files.add(await MultipartFile.fromPath("documents" + '[${files.indexOf(element)}]', element.path));
    //   });
    // }
    //
    // log("Request ${multiPartRequest.fields}");
    // log("Request ${multiPartRequest.files.length}");
    //
    // multiPartRequest.headers.addAll(buildHeaderTokens());
    //
    // sendMultiPartRequest(
    //   multiPartRequest,
    //   onSuccess: (data) async {
    //     appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: false);
    //     AddDocumentResponse res = AddDocumentResponse.fromJson(jsonDecode(data));
    //
    //     toast(res.message.validate(), print: true);
    //     finish(getContext, true);
    //   },
    //   onError: (error) {
    //     appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketsNotesApiState, value: false);
    //     toast(error.toString(), print: true);
    //   },
    // );

    return AddDocumentResponse();
  }
}
