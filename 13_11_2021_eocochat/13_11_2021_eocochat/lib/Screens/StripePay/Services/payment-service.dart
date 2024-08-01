import 'dart:convert';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String? message;
  String? paymentIntentId;
  bool? success;
  StripeTransactionResponse({this.message, this.success,this.paymentIntentId});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = stripeSecretKey!;
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: stripePublishKey,
        merchantId: "Test",
        androidPayMode: 'test'
      )
    );
  }

  static Future<StripeTransactionResponse> payViaExistingCard({String? amount, String? currency, CreditCard? card}) async{
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(PaymentMethodRequest(card: card));
      var paymentIntent = await StripeService.createPaymentIntent(amount!, currency!);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(clientSecret: paymentIntent!['client_secret'], paymentMethodId: paymentMethod.id));
      print('payWithNewCard response : ${response.toString()}');
      if (response.status == 'succeeded') {
        print('payViaExistingCard response.status : ${response.status.toString()}');
        return new StripeTransactionResponse(message: 'Transaction successful', success: true);
      } else {
        print('payViaExistingCard response.status : ${response.status.toString()}');
        return new StripeTransactionResponse(message: 'Transaction failed', success: false);
      }
    } on PlatformException catch(err) {
      print('err : ${err.toString()}');
      return new StripeTransactionResponse(message: 'Transaction failed: ${err.message.toString()}', success: false,paymentIntentId: null);
      // return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      print('err : ${err.toString()}');
      return new StripeTransactionResponse(message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard({String? amount, String? currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
      var paymentIntent = await StripeService.createPaymentIntent(amount!, currency!);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(clientSecret: paymentIntent!['client_secret'], paymentMethodId: paymentMethod.id));
      print('payWithNewCard response : ${response.toJson().toString()}');
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(message: 'Transaction successful', success: true,paymentIntentId: response.paymentIntentId);
      } else {
        return new StripeTransactionResponse(message: 'Transaction failed', success: false,paymentIntentId: response.paymentIntentId);
      }
    } on PlatformException catch(err) {
      print('payWithNewCard response : ${err.message.toString()}');
      return new StripeTransactionResponse(message: 'Transaction failed: ${err.message.toString()}', success: false,paymentIntentId: null);
      // return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(message: 'Transaction failed: ${err.toString()}', success: false,paymentIntentId: null);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse(StripeService.paymentApiUrl),
          body: body,
          headers: StripeService.headers
      );
      print('createPaymentIntent response.body : ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('createPaymentIntent ERROR : ${err.toString()}');
    }
    return null;
  }
}
