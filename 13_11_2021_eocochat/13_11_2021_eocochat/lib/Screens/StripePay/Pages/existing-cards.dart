
import 'package:fiberchat/Screens/StripePay/Services/payment-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';

class ExistingCardsPage extends StatefulWidget {
  // ExistingCardsPage({Key key}) : super(key: key);

  @override
  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {
  List cards = [{
    'cardNumber': '4242424242424242',
    'expiryDate': '04/24',
    'cardHolderName': 'Parth Unagar',
    'cvvCode': '424',
    'showBackView': true,
  },
    {
    'cardNumber': '4000008260000000',
    'expiryDate': '04/23',
    'cardHolderName': 'Tracer',
    'cvvCode': '123',
    'showBackView': false,
  },
    {
    'cardNumber': '4000003560000008',
    'expiryDate': '04/23',
    'cardHolderName': 'Parth Savaliya',
    'cvvCode': '123',
    'showBackView': false,
  }
  ];

  payViaExistingCard(BuildContext context, card) async {
    showProgress(context,card);
  }

  Future<void> showProgress(BuildContext context, card) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(card), message: Text('Please wait...')),
    );
    showResultDialog(context, result);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose existing card')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            var card = cards[index];
            return InkWell(
              onTap: () {
                payViaExistingCard(context, card);
              },
              child: CreditCardWidget(
                cardNumber: card['cardNumber'],
                expiryDate: card['expiryDate'],
                cardHolderName: card['cardHolderName'],
                cvvCode: card['cvvCode'],
                showBackView: false,//card['showBackView'],
              ),
            );
          },
        ),
      ),
    );
  }

  void showResultDialog(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(result),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  Future getFuture(card)  {
    return Future(() async {
      var expiryArr = card['expiryDate'].split('/');
      CreditCard stripeCard = CreditCard(number: card['cardNumber'], expMonth: int.parse(expiryArr[0]), expYear: int.parse(expiryArr[1]));
      print('payViaExistingCard stripeCard : ${stripeCard.toString()}');
      var response = await StripeService.payViaExistingCard(amount: '80', currency: 'EUR', card: stripeCard);
      print('payViaExistingCard response : ${response.toString()}');
      print('payViaExistingCard response.message : ${response.message.toString()}');
      return response.message.toString();
    });
  }
}