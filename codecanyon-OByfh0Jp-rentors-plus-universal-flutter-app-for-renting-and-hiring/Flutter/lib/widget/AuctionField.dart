import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuctionField extends StatefulWidget {
  final TextEditingController mController;
  final int maxline;
  final bool disableContentPadding;

  final bool readOnly;

  final String hint;
  final Function onTap;
  final TextInputType inputType;

  AuctionField(
      {this.mController,
      this.maxline = 1,
      this.disableContentPadding = true,
      this.readOnly = false,
      this.hint,
      this.onTap,
      this.inputType});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AuctionFieldState();
  }
}

class AuctionFieldState extends State<AuctionField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
        onTap: widget.onTap,
        keyboardType: widget.inputType,
        readOnly: widget.readOnly,
        maxLines: widget.maxline,
        controller: widget.mController,
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).buttonColor)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).buttonColor)),
            labelStyle: TextStyle(
              color: Theme.of(context).buttonColor,
            )));
  }
}
