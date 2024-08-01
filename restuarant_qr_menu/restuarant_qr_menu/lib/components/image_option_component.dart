import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/file_picker_dialog_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';

class ImageOptionComponent extends StatefulWidget {
  String? defaultImage;
  String? name;
  final Function(File? image) onImageSelected;

  ImageOptionComponent({this.defaultImage, required this.onImageSelected, this.name});

  @override
  _ImageOptionComponentState createState() => _ImageOptionComponentState();
}

class _ImageOptionComponentState extends State<ImageOptionComponent> {
  File? image;
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    isUpdate = !widget.defaultImage.isEmptyOrNull;
  }

  Widget getImagePlatform({double? height, double? width}) {
    if (!isUpdate) {
      if (image != null) {
        return Image.file(
          File(image!.path.validate()),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ).cornerRadiusWithClipRRect(defaultRadius);
      } else {
        return Image.asset(
          AppImages.empty_image_placeholder,
          alignment: Alignment.center,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ).cornerRadiusWithClipRRect(defaultRadius);
      }
    } else {
      if (image != null) {
        return Image.file(
          File(image!.path.validate()),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ).cornerRadiusWithClipRRect(defaultRadius);
      } else {
        return cachedImage(widget.defaultImage, fit: BoxFit.fill, height: height, width: width).cornerRadiusWithClipRRect(defaultRadius);
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: context.width(),
            height: 160,
            decoration: BoxDecoration(
              borderRadius: radius(defaultRadius),
              border: Border.all(color: context.dividerColor),
              color: context.cardColor,
            ),
            child: getImagePlatform(height: 120, width: context.width()),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: radius(defaultRadius),
                color: primaryColor,
              ),
              child: IconButton(
                onPressed: () async {
                  FileType file = await showInDialog(
                    context,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    title: Text(language.lblChooseAnAction, style: boldTextStyle()),
                    builder: (p0) {
                      return FilePickerDialog(isSelected: (isUpdate || image != null));
                    },
                  );
                  if (file == FileType.CANCEL) {
                    image = null;
                    widget.defaultImage = null;
                    isUpdate = false;
                    widget.onImageSelected.call(null);
                    return;
                  }
                  image = await getImageSource(isCamera: file == FileType.CAMERA ? true : false);
                  widget.onImageSelected.call(image!);
                  setState(() {});
                },
                icon: Icon(Icons.edit, color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
