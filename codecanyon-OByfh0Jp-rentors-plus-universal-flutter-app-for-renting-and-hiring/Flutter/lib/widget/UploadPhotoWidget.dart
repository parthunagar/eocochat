import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentors/bloc/UploadPhotoBloc.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/UploadPhotoEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UploadPhotoDoneState.dart';
import 'package:rentors/util/TypeEnum.dart';
import 'package:rentors/widget/ProgressDialog.dart';

class UploadPhotoWidget extends StatefulWidget {
  final String name;
  final TypeEnum typeEnum;
  final void Function(String url, TypeEnum typeEnum) imageSelectionCallback;

  final Widget child;

  UploadPhotoWidget(this.name, this.typeEnum, this.imageSelectionCallback,
      {this.child});

  @override
  State<StatefulWidget> createState() {
    return UploadPhotoWidgetState();
  }
}

class UploadPhotoWidgetState extends State<UploadPhotoWidget> {
  UploadPhotoBloc bookingBloc = UploadPhotoBloc();

  ProgressDialog dialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingBloc.listen((state) {
      if (state is UploadPhotoDoneState) {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        widget.imageSelectionCallback(state.home.url, state.typeEnum);
        RentorState.of(context)?.updateView(state.home.url);
      } else if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.style(message: S.of(context).uploading);
        dialog.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPicker(context, widget.typeEnum);
      },
      child: widget.child == null
          ? SizedBox(
              width: 150,
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/img/frame.svg",
                    width: 120,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      widget.name,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          : widget.child,
    );
  }

  void _showPicker(context, TypeEnum typeEnum) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(S.of(context).photoLibrary),
                      onTap: () {
                        _imgFromGallery(typeEnum);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(S.of(context).camera),
                    onTap: () {
                      _imgFromCamera(typeEnum);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(TypeEnum typeEnum) async {
    var picker = ImagePicker();
    var image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 70);
    bookingBloc.add(UploadPhotoEvent(image, typeEnum));
  }

  _imgFromGallery(TypeEnum typeEnum) async {
    var picker = ImagePicker();
    var image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 70);
    bookingBloc.add(UploadPhotoEvent(image, typeEnum));
  }
}
