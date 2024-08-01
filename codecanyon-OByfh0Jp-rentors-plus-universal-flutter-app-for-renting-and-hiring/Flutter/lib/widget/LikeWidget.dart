import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentors/bloc/WishBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/LikeEvent.dart';
import 'package:rentors/event/UnLikeEvent.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/widget/ProgressDialog.dart';

class LikeWidget extends StatefulWidget {
  final String productId;
  final String isLike;

  LikeWidget(this.productId, this.isLike);

  @override
  State<StatefulWidget> createState() {
    return LikeWidgetState();
  }
}

class LikeWidgetState extends State<LikeWidget> {
  WishBloc mBloc;
  ProgressDialog mDialog;

  @override
  void initState() {
    super.initState();
    mBloc = WishBloc();
    mBloc.listen((state) {
      if (state is DoneState) {
        if (mDialog != null && mDialog.isShowing()) {
          mDialog.hide();
          mDialog = null;
        }
        Fluttertoast.showToast(msg: state.home.message);
        RentorState.of(context).update();
      } else if (state is ProgressDialogState) {
        mDialog = ProgressDialog(context);
        mDialog.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => WishBloc(),
        child: BlocBuilder<WishBloc, BaseState>(
            bloc: mBloc,
            builder: (BuildContext context, BaseState state) {
              return InkWell(
                onTap: () {
                  if (widget.isLike == "0") {
                    mBloc.add(LikeEvent(widget.productId));
                  } else {
                    mBloc.add(UnLikeEvent(widget.productId));
                  }
                },
                child: widget.isLike == "0"
                    ? Icon(
                        CupertinoIcons.heart,
                        color: config.Colors().color545454,
                      )
                    : Icon(CupertinoIcons.heart_solid,
                        color: config.Colors().statusRedColor),
              );
            }));
  }
}
