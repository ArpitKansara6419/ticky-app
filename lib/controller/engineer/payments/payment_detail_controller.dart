import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/payments/add_payment_detail_response.dart';
import 'package:ticky/model/engineer/payments/payment_details_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class PaymentDetailController {
  static Future<PaymentDetailsResponse> getPaymentDetailListApi() async {
    PaymentDetailsResponse res = PaymentDetailsResponse.fromJson(await handleResponse(await buildHttpResponse(PaymentDetailEndPoints.getPaymentDetailsUrl + "/${userStore.userId}")));

    return res;
  }

  static Future<AddPaymentDetailResponse> addPaymentDetailApi({required Map<String, dynamic> request}) async {
    log("Request $request");
    AddPaymentDetailResponse res =
        AddPaymentDetailResponse.fromJson(await handleResponse(await buildHttpResponse(PaymentDetailEndPoints.savePaymentDetailsUrl, request: request, method: HttpMethod.POST)));
    return res;
  }
}
