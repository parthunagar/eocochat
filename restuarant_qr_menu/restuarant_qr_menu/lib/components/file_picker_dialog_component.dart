import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/constants.dart';

class FilePickerDialog extends StatelessWidget {
  final bool isSelected;

  FilePickerDialog({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingItemWidget(
            title: language.lblRemoveImage,
            titleTextStyle: primaryTextStyle(),
            leading: Icon(Icons.close, color: context.iconColor),
            onTap: () {
              finish(context, FileType.CANCEL);
            },
          ).visible(isSelected),
          SettingItemWidget(
            title: language.lblCamera,
            titleTextStyle: primaryTextStyle(),
            leading: Icon(LineIcons.camera, color: context.iconColor),
            onTap: () {
              finish(context, FileType.CAMERA);
            },
          ),
          SettingItemWidget(
            title: language.lblGallery,
            titleTextStyle: primaryTextStyle(),
            leading: Icon(LineIcons.image_1, color: context.iconColor),
            onTap: () {
              finish(context, FileType.GALLERY);
            },
          ),
        ],
      ),
    );
  }
}
