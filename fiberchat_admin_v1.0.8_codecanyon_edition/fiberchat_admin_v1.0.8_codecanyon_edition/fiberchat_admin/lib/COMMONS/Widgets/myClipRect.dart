import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/COMMONS/Configs/NumberLimits.dart';

myCliprectLogo(Widget widget) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(Numberlimits.defaultclipradius),
      child: widget);
}
