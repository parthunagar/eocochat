import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentors/bloc/ChangePasswordBloc.dart';
import 'package:rentors/event/ChangePasswordEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/widget/PasswordField.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordScreenState();
  }
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordBloc mBloc = ChangePasswordBloc();
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  final _oldPasswordKey = GlobalKey<FormFieldState<String>>();
  final _newPasswordKey = GlobalKey<FormFieldState<String>>();
  final _confirmPasswordKey = GlobalKey<FormFieldState<String>>();

  TextEditingController commentController = new TextEditingController();
  ProgressDialog dialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.show();
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state is DoneState) {
          Fluttertoast.showToast(msg: state.home.message);
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: PasswordField(
                  controller: oldPasswordController,
                  validator: (input) =>
                      input.isEmpty ? S.of(context).pleaseEnterPassword : null,
                  fieldKey: _oldPasswordKey,
                  hint: S.of(context).oldPassword,
                  onFieldSubmitted: (String value) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: PasswordField(
                  controller: newPasswordController,
                  validator: (input) => input.isEmpty
                      ? S.of(context).newPasswordShouldNotBeEmpty
                      : null,
                  fieldKey: _newPasswordKey,
                  hint: S.of(context).newPassword,
                  onFieldSubmitted: (String value) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: PasswordField(
                  controller: confirmPasswordController,
                  validator: (input) => input.isEmpty
                      ? S.of(context).confirmPasswordShouldNotBeEmpty
                      : null,
                  fieldKey: _confirmPasswordKey,
                  hint: S.of(context).confirmPassword,
                  onFieldSubmitted: (String value) {},
                ),
              ),
              BlocProvider(
                  create: (BuildContext context) => ChangePasswordBloc(),
                  child: BlocBuilder<ChangePasswordBloc, BaseState>(
                      bloc: mBloc,
                      builder: (BuildContext context, BaseState state) {
                        return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: RentorRaisedButton(
                              onPressed: () {
                                addComplaint();
                              },
                              child: Text(
                                S.of(context).submit,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                            ));
                      }))
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(S.of(context).changePassword),
        ));
  }

  void addComplaint() {
    if (_oldPasswordKey.currentState.validate() &&
        _newPasswordKey.currentState.validate() &&
        _confirmPasswordKey.currentState.validate()) {
      String newPassword = newPasswordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      if (newPassword != confirmPassword) {
        Fluttertoast.showToast(
            msg: S.of(context).newPasswordAndConfirmPasswordShouldBeSame);
      } else {
        mBloc.add(ChangePasswordEvent(newPassword));
      }
    }
//    String title = titleController.text.trim();
//    String comment = commentController.text.trim();
//    if (title.isEmpty) {
//      Fluttertoast.showToast(msg: S.of(context).pleaseAddTitle);
//    } else if (comment.isEmpty) {
//      Fluttertoast.showToast(msg: S.of(context).pleaseAddDetails);
//    } else {
//      mBloc.add(ComplaintEvent(title, comment));
//      titleController.clear();
//      commentController.clear();
//    }
  }
}
