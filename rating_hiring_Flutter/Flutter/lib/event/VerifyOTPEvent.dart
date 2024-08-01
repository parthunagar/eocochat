import 'package:flutter/material.dart';
import 'package:rentors/event/BaseEvent.dart';

@immutable
class VerifyOTPEvent extends BaseEvent {
  final String verifiedId;
  final String smsCode;

  VerifyOTPEvent(this.verifiedId, this.smsCode) ;

  @override
  List<Object> get props {
    var prop = super.props;
    prop.addAll([verifiedId, smsCode]);
    return prop;
  }
}
