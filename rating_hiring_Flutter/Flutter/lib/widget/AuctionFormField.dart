import 'package:flutter/material.dart';

class AuctionFormField extends StatefulWidget {
  final String labelHint;

  final TextEditingController mController;
  final int maxline;
  final bool disableContentPadding;

  final bool readOnly;

  final String hint;

  AuctionFormField(this.labelHint,
      {this.mController,
      this.maxline = 1,
      this.disableContentPadding = true,
      this.readOnly = false,
      this.hint});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AuctionFormFieldState();
  }
}

class AuctionFormFieldState extends State<AuctionFormField> {
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
        child: Focus(
            child: TextField(
                readOnly: widget.readOnly,
                maxLines: widget.maxline,
                controller: widget.mController,
                decoration: InputDecoration(
                    contentPadding: widget.disableContentPadding
                        ? EdgeInsets.only(left: 10, right: 10)
                        : null,
                    labelText: widget.labelHint,
                    hintText: widget.hint,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).buttonColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45)),
                    labelStyle: TextStyle(
                      color: focus
                          ? Theme.of(context).buttonColor
                          : Theme.of(context).hintColor,
                    )))));
  }
}
