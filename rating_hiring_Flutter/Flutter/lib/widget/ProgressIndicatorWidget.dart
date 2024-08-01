import 'package:flutter/material.dart';
import 'package:rentors/widget/CenterHorizontal.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CenterHorizontal(CircularProgressIndicator())],
    );
  }
}
