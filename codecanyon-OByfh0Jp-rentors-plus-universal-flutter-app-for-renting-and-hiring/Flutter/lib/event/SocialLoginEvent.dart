import 'package:flutter/material.dart';
import 'package:rentors/event/BaseEvent.dart';

@immutable
class SocialLoginEvent extends BaseEvent {
  final String social_type;
  final String social_id;
  final String first_name;
  final String last_name;
  final String device_token;

  SocialLoginEvent(this.social_type, this.social_id, this.first_name, this.last_name,this.device_token);

  @override
  List<Object> get props {
    var prop = super.props;
    prop.addAll([social_type,social_id,first_name,last_name,device_token]);
    return prop;
  }
}
