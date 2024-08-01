import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/event/FeatureSubscriptionEvent.dart';
import 'package:rentors/event/PaymentEvent.dart';
import 'package:rentors/event/UserSubscriptionEvent.dart';
import 'package:rentors/repo/PaymentRepo.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/GatewayPaymentState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentBloc extends Bloc<BaseEvent, BaseState> {
  @override
  // TODO: implement initialState
  BaseState get initialState => LoadingState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is PaymentEvent) {
      yield ProgressDialogState();

      var cardInfo = event.cardInfo;
      var card = CreditCard();
      card.name = cardInfo.name;
      card.number = cardInfo.cardNumber;
      card.cvc = cardInfo.cvv;
      card.expMonth = int.parse(cardInfo.validate.split("/")[0]);
      card.expYear = int.parse(cardInfo.validate.split("/")[1]);
      var paymentSecret =
          await getStripePaymentSecret(event.packageId, event.note);
      String clientSecret = paymentSecret.data.clientSecret;
      try {
        var paymentMethod = await StripePayment.createPaymentMethod(
            PaymentMethodRequest(card: card));
        var result = await StripePayment.confirmPaymentIntent(PaymentIntent(
            clientSecret: clientSecret, paymentMethodId: paymentMethod.id));
        yield GatewayPaymentState(result.toJson().toString());
      } catch (ex) {
        yield ErrorState(ex.toString());
      }
    } else if (event is FeatureSubscriptionEvent) {
      yield ProgressDialogState();
      var res = await subscribeFeatureRentor(
          event.productId, event.subscriptionid, event.details);
      yield DoneState(res);
    }else if (event is UserSubscriptionEvent) {
      yield ProgressDialogState();
      var res = await subscribeUser(
          event.subscriptionid, event.details);
      yield DoneState(res);
    }
  }
}
