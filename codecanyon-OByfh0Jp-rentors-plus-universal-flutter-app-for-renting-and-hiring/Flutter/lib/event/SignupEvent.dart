import 'package:flutter/material.dart';
import 'package:rentors/event/BaseEvent.dart';

@immutable
class SignupEvent extends BaseEvent {
  final String email;
  final String password;
  final String type;
  final String name;

  SignupEvent(this.email, this.password, this.name, this.type);

  @override
  List<Object> get props {
    var prop = super.props;
    prop.addAll([email, password]);
    return prop;
  }
}
