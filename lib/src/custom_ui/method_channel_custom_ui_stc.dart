import 'package:flutter/services.dart';
import '../../flutter_hyperpay.dart';
import '../../model/custom_ui_stc.dart';
import '../helper/helper.dart';

/// implementPaymentCustomUISTC is a method used to make online payments.
/// It requires the paymentMode, checkoutId, channelName, shopperResultUrl,
/// phoneNumber and lang to be passed as arguments for successful implementation.
/// It returns a PaymentResultData object with the paymentResult and errorString.
Future<PaymentResultData> implementPaymentCustomUISTC({
  required PaymentMode paymentMode,
  required String channelName,
  required String shopperResultUrl,
  required String lang,
  required STCTransaction transaction,
}) async {
  String transactionStatus;
  var platform = MethodChannel(channelName);
  try {
    final String? result = await platform.invokeMethod(
      PaymentConst.methodCall,
      getCustomUiSTCModelCards(
          shopperResultUrl: shopperResultUrl,
          paymentMode: paymentMode,
          transaction: transaction,
          lang: lang),
    );
    transactionStatus = '$result';
    return PaymentResultManger.getPaymentResult(transactionStatus);
  } on PlatformException catch (e) {
    transactionStatus = "${e.message}";
    return PaymentResultData(
        errorString: e.message, paymentResult: PaymentResult.error);
  }
}

/// This method creates a map of parameters to be used for a custom UI STC (STC Pay) payment.
/// It requires the payment mode, phone number, checkout ID, language,
/// and shopper result URL as parameters. It returns a map containing data for the payment type,
/// mode, checkout id, phone number, language, and shopper result URL.
Map<String, String?> getCustomUiSTCModelCards({
  required PaymentMode paymentMode,
  required String lang,
  required String shopperResultUrl,
  required STCTransaction transaction,
}) {
  return {
    "mode": paymentMode.toString().split('.').last,
    "lang": lang,
    "ShopperResultUrl": shopperResultUrl,
    ...transaction.toMap(),
  };
}
