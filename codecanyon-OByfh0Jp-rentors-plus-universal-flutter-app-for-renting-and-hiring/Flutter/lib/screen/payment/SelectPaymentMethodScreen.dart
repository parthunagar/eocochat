import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/FeatureSubscriptionList.dart';
import 'package:rentors/widget/ProgressDialog.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  final String productId;
  final Feature feature;

  SelectPaymentMethodScreen(this.productId, {this.feature});

  @override
  State<StatefulWidget> createState() {
    return SelectPaymentMethodScreenState();
  }
}

enum PaymentMethod { Stripe, RazorPay, Flutterwave }

class SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  ProgressDialog dialog;
  PaymentMethod selectePayment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // mBloc.listen((state) {
    //   if (state is ProgressDialogState) {
    //     dialog = ProgressDialog(context, isDismissible: true);
    //     dialog.show();
    //   } else {
    //     if (dialog != null && dialog.isShowing()) {
    //       dialog.hide();
    //     }
    //     if (state is DoneState) {
    //       Fluttertoast.showToast(msg: state.home.message);
    //       Navigator.of(context).pop();
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: config.Colors().orangeColor)),
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Text(
                      S.of(context).youHaveSelected(
                          widget.feature.title,
                          widget.feature.currencyType +
                              " " +
                              widget.feature.price),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        S
                            .of(context)
                            .yourFeatureSubscriptionWillBeForForYourSelectedProduct(
                                widget.feature.period),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/img/stripe.png",
                  ),
                ),
                leading: Radio(
                  value: PaymentMethod.Stripe,
                  groupValue: selectePayment,
                  onChanged: (PaymentMethod value) {
                    setState(() {
                      selectePayment = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/img/razorpay.png",
                  ),
                ),
                leading: Radio(
                  value: PaymentMethod.RazorPay,
                  groupValue: selectePayment,
                  onChanged: (PaymentMethod value) {
                    setState(() {
                      selectePayment = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/img/flutterwave.png",
                  ),
                ),
                leading: Radio(
                  value: PaymentMethod.Flutterwave,
                  groupValue: selectePayment,
                  onChanged: (PaymentMethod value) {
                    setState(() {
                      selectePayment = value;
                    });
                  },
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    gotoCheckout();
                  },
                  child: Text(
                    S.of(context).continuee,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
              // BlocProvider(
              //     create: (BuildContext context) => ComplaintBloc(),
              //     child: BlocBuilder<ComplaintBloc, BaseState>(
              //         bloc: mBloc,
              //         builder: (BuildContext context, BaseState state) {
              //           return Container(
              //               width: double.infinity,
              //               margin: EdgeInsets.only(top: 10, bottom: 10),
              //               child: RaisedButton(
              //                 onPressed: () {
              //                   addComplaint();
              //                 },
              //                 child: Text(
              //                   S.of(context).submit,
              //                   style: TextStyle(
              //                       color: Theme.of(context)
              //                           .scaffoldBackgroundColor),
              //                 ),
              //               ));
              //         }))
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(S.of(context).selectPaymentMethod),
        ));
  }

  void gotoCheckout() {
    var bpdy = Map();
    bpdy["feat"] = widget.feature;
    bpdy["prod"] = widget.productId;
    bpdy["t"] = selectePayment;
    Navigator.of(context).pushNamed("/payment_checkout", arguments: bpdy);
  }
}
