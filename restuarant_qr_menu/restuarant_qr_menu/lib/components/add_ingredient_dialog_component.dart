import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';

class AddIngredientDialogComponent extends StatefulWidget {
  final String? value;

  AddIngredientDialogComponent({this.value});

  @override
  _AddIngredientDialogComponentState createState() => _AddIngredientDialogComponentState();
}

List<String> ingredient = [];

class _AddIngredientDialogComponentState extends State<AddIngredientDialogComponent> {
  TextEditingController ingredientCont = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    isUpdate = widget.value != null;
    if (isUpdate) {
      ingredientCont.text = widget.value.validate();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: context.width(),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.height,
            Text(isUpdate ? '${language.lblUpdateIngredient}' : '${language.lblAddIngredient}', style: boldTextStyle()),
            16.height,
            AppTextField(
              isValidationRequired: true,
              decoration: inputDecoration(context, label: "${language.lblName}").copyWith(prefixIcon: Icon(Icons.drive_file_rename_outline, color: secondaryIconColor)),
              controller: ingredientCont,
              textFieldType: TextFieldType.NAME,
            ),
            32.height,
            Row(
              children: [
                AppButton(
                  color: context.cardColor,
                  child: Text('${language.lblCancel}', style: boldTextStyle()),
                  onTap: () {
                    hideKeyboard(context);
                    finish(context);
                  },
                ).expand(),
                8.width,
                AppButton(
                  color: primaryColor,
                  text: isUpdate ? "${language.lblUpdate}" : "${language.lblAdd}",
                  textStyle: primaryTextStyle(color: Colors.white),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (ingredientCont.text.isNotEmpty) {
                        if (isUpdate) {
                          ingredient[ingredient.indexWhere((element) => element == widget.value)] = ingredientCont.text;
                          hideKeyboard(context);
                          finish(context);
                          setState(() {
                            ingredientCont.text = '';
                          });
                        } else {
                          ingredient.add(ingredientCont.text.validate());
                          hideKeyboard(context);
                          finish(context);
                          setState(() {
                            ingredientCont.text = '';
                          });
                        }
                      }
                    }
                  },
                ).expand(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
