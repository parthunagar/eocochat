import 'package:flutter/material.dart';

class RoundedFloatingField extends StatefulWidget {
  final TextEditingController controller;
  final int maxline;
  final bool disableContentPadding;

  final bool readOnly;
  final String hint;
  final String label;
  final GlobalKey<FormFieldState<String>> emailIdKey;

  final FormFieldValidator<String> validator;
  final TextInputType inputType;

  RoundedFloatingField(
      {this.controller,
      this.emailIdKey,
      this.maxline = 1,
      this.disableContentPadding = true,
      this.readOnly = false,
      this.hint,
      this.label,
      this.validator,
      this.inputType});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AuctionFormFieldState();
  }
}

class AuctionFormFieldState extends State<RoundedFloatingField> {
  bool focus = false;

  @override
  void initState() {
    // TODO: implement initState
    focus = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FocusScope(
        onFocusChange: (value) {
          setState(() {
            focus = value;
          });
        },
        child: TextFormField(
          controller: widget.controller,
          key: widget.emailIdKey,
          autofocus: false,
          validator: widget.validator,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(color: Theme.of(context).accentColor),
            contentPadding: EdgeInsets.all(12),
            hintText: widget.hint,
            hintStyle:
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
          ),
        ));
  }
}
