import 'package:credit_card_input_form/model/card_info.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/screen/payment/SelectPaymentMethodScreen.dart'
    as payment;

class PaymentEvent extends BaseEvent {
  final payment.PaymentMethod method;
  final CardInfo cardInfo;
  final String packageId;

  final String note;

  PaymentEvent(this.method, {this.cardInfo, this.packageId, this.note});
}
