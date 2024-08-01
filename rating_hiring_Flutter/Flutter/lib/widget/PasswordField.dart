import 'package:flutter/material.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/generated/l10n.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
    this.hint,
  });

  final Key fieldKey;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;
  final String hint;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
        key: widget.fieldKey,
        controller: widget.controller,
        obscureText: _obscureText,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: new Icon(
              !_obscureText ? Icons.visibility : Icons.visibility_off,
              color: _obscureText ? Colors.grey : config.Colors().orangeColor,
            ),
          ),
          labelText: widget.hint == null ? S.of(context).password : widget.hint,
          labelStyle: TextStyle(color: Theme.of(context).accentColor),
          contentPadding: EdgeInsets.all(12),
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
        ));
  }
}
