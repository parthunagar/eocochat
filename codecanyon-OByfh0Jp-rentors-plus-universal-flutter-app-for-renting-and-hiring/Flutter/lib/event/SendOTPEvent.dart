import 'package:flutter/material.dart';
import 'package:rentors/event/BaseEvent.dart';

@immutable
class SendOTPEvent extends BaseEvent {
  final String countryCode;
  final String phoneNumber;

  SendOTPEvent(this.countryCode, this.phoneNumber);

  @override
  List<Object> get props {
    var prop = super.props;
    prop.addAll([countryCode, phoneNumber]);
    return prop;
  }
}
