import 'package:flutter/material.dart';

class RentorRaisedButton extends StatelessWidget {
  final Widget child;

  @required
  final VoidCallback onPressed;

  RentorRaisedButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF25432), Color(0xFFF19058)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          // min sizes for Material buttons
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
