import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/education/add_education_response.dart';
import 'package:ticky/model/leaves/leave_response.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/enums.dart';

import '../../network/api_client.dart';

class LeavesController {
  static Future<LeaveResponse> getAttendanceApi() async {
    LeaveResponse res = LeaveResponse.fromJson(await handleResponse(await buildHttpResponse(LeavesEndPoints.getLeavesListUrl + "/${userStore.userId}")));

    leaveStore.leaveBalance = res.leaveResponseData!.stats!.leaveBalance.validate().toDouble();

    return res;
  }

  static Future<AddEducationResponse> applyLeaveApiMultipart({
    required Map<String, dynamic> request,
    File? paidDocument,
    File? unpaidDocument,
    File? paidSignedDocument,
    File? unpaidSignedDocument,
    bool isPop = true,
  }) async {
    mainLog(
      message: jsonEncode(request),
      label: 'applyLeaveApiMultipart request => ',
    );
    MultipartRequest multiPartRequest = await getMultiPartRequest(LeavesEndPoints.saveLeavesUrl);
    multiPartRequest.headers.addAll(buildHeaderTokens());

    request.forEach((key, value) {
      multiPartRequest.fields[key] = value.toString();
    });

    if (paidDocument != null) {
      multiPartRequest.files.add(await MultipartFile.fromPath("unsigned_paid_document", paidDocument.path));
    }

    if (unpaidDocument != null) {
      multiPartRequest.files.add(await MultipartFile.fromPath("unsigned_unpaid_document", unpaidDocument.path));
    }

    if (paidSignedDocument != null) {
      multiPartRequest.files.add(await MultipartFile.fromPath("signed_paid_document", paidSignedDocument.path));
    }

    if (unpaidSignedDocument != null) {
      multiPartRequest.files.add(await MultipartFile.fromPath("signed_unpaid_document", unpaidSignedDocument.path));
    }

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.headers}");
    log("Request ${multiPartRequest.files.map((e) => e.field)}");

    await sendMultiPartRequest(
      multiPartRequest,
      showSomethingWentWrong: false,
      onSuccess: (data) async {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
        AddEducationResponse res = AddEducationResponse.fromJson(jsonDecode(data));

        toast(res.message.validate(), print: true);
        if (isPop) finish(getContext, true);
      },
      onError: (error) {
        toast(error.toString(), print: true);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false));

    return AddEducationResponse();
  }
}
