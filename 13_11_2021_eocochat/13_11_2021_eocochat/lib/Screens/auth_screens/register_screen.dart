import 'dart:io';
import 'dart:ui';
import 'package:device_info/device_info.dart';
import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:fiberchat/Screens/security_screens/security.dart';
import 'package:fiberchat/Services/API/api_service.dart';
import 'package:fiberchat/Services/Providers/Observer.dart';
import 'package:fiberchat/Utils/unawaited.dart';
import 'package:fiberchat/main.dart';
import 'package:fiberchat/widgets/PhoneField/intl_phone_field.dart';
import 'package:fiberchat/widgets/PhoneField/phone_number.dart';
import 'package:fiberchat/Configs/app_constants.dart';
import 'package:fiberchat/Services/localization/language.dart';
import 'package:fiberchat/Services/localization/language_constants.dart';
import 'package:fiberchat/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fiberchat/Configs/Enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  SharedPreferences? prefs;

  RegisterScreen({this.prefs});

  @override
  RegisterScreenState createState() => new RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _phoneNo = TextEditingController();
  String? countryISOCode = DEFAULT_COUNTTRYCODE_ISO;

  String? phoneCode = DEFAULT_COUNTTRYCODE_NUMBER;
  final storage = new FlutterSecureStorage();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  int _currentStep = 0;

  String? verificationId;
  bool isLoading = false;
  bool isLoading2 = true;
  bool isverficationsent = false;
  dynamic isLoggedIn = false;
  User? currentUser;
  String? deviceid;
  var mapDeviceInfo = {};

  @override
  void initState() {
    super.initState();
    // setdeviceinfo();
    seletedlanguage = Language.languageList().where((element) => element.languageCode == 'en').toList()[0];
  }




  Language? seletedlanguage;
  customclippath(double w, double h) {
    return ClipPath(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: DESIGN_TYPE == Themetype.whatsapp ? [eocochatYellow, eocochatYellow] : [eocochatWhite, eocochatWhite]),
        ),
        child: Column(
          children: [
            SizedBox(height: Platform.isIOS ? 0 : 10),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
            ),
            SizedBox(height: w > h ? 0 : 15),
            w < h ? Image.asset(AppLogoPath, width: w / 1.3) : Image.asset(AppLogoPath, height: h / 6),
            SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  // final _enterNumberFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final observer = Provider.of<Observer>(context, listen: true);
    return Fiberchat.getNTPWrappedWidget(Scaffold(
      backgroundColor: DESIGN_TYPE == Themetype.whatsapp ? eocochatYellow : eocochatWhite,
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  customclippath(w, h),
                   Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3.0,
                              color: DESIGN_TYPE == Themetype.whatsapp ? eocochatYellow : eocochatBlack.withOpacity(0.1),
                              spreadRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.fromLTRB(15, MediaQuery.of(context).size.height / 2.75, 16, 0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 13),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              // height: 63,
                              height: 83,
                              width: w / 1.24,
                              child: InpuTextBox(
                                controller: _userName,
                                leftrightmargin: 0,
                                showIconboundary: false,
                                boxcornerradius: 5.5,
                                boxheight: 50,
                                hinttext: getTranslated(this.context, 'name_hint'),
                                prefixIconbutton: Icon(Icons.person, color: Colors.grey.withOpacity(0.5)),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              // height: 63,
                              height: 83,
                              width: w / 1.24,
                              child: InpuTextBox(
                                controller: _email,
                                leftrightmargin: 0,
                                showIconboundary: false,
                                boxcornerradius: 5.5,
                                boxheight: 50,
                                hinttext: getTranslated(this.context, 'enterYourEmail'),// getTranslated(this.context, 'name_hint'),
                                prefixIconbutton: Icon(Icons.mail, color: Colors.grey.withOpacity(0.5)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              // height: 63,
                              height: 63,
                              width: w / 1.24,
                              child: Form(
                                // key: _enterNumberFormKey,
                                child: MobileInputWithOutline(
                                  buttonhintTextColor: eocochatGrey,
                                  borderColor: eocochatGrey.withOpacity(0.2),
                                  controller: _phoneNo,
                                  initialCountryCode:  DEFAULT_COUNTTRYCODE_ISO,
                                  onSaved: (phone) {
                                    setState(() {
                                      phoneCode = phone!.countryCode;
                                    });
                                  },
                                  onCountryChanged: (phone) {
                                    setState(() {
                                      countryISOCode = phone!.countryISOCode;
                                      phoneCode = phone.countryCode;
                                      print('onCountryChanged => countryISOCode : $countryISOCode}');
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(17, 22, 17, 5),
                              child: isLoading == true
                                  ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(eocochatYellow)))
                                  : MySimpleButton(
                                spacing: 0.3,
                                height: 57,
                                buttoncolor: DESIGN_TYPE == Themetype.whatsapp ? eocochatLightGreen : eocochatYellow,
                                buttontext: getTranslated(context, 'register'),// getTranslated(this.context, 'sendverf'),
                                onpressed:() {
                                  setState(() {});
                                  print('Register');
                                  RegExp e164 = new RegExp(r'^\+[1-9]\d{1,14}$');
                                  if (_userName.text.trim().isNotEmpty) {
                                    if(_userName.text.length >= 6) {
                                      if(_email.text.trim().isNotEmpty) {
                                        if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text.trim().toString())){
                                          String _phone = _phoneNo.text.toString().trim();
                                          if (_phone.isNotEmpty && e164.hasMatch(phoneCode! + _phone)) {
                                            setState(() {
                                              isLoading = true;
                                              _currentStep = 1;
                                              print('_userName.text : ${_userName.text}');
                                              print('_email.text : ${_email.text}');
                                              print('_phoneNo.text : ${_phoneNo.text}');
                                              print('phoneCode : $phoneCode');
                                              print('DEFAULT_COUNTTRYCODE_ISO : $countryISOCode'); //+91
                                              callRegisterApi(
                                                _userName.text.toString(),
                                                _email.text.toString(),
                                                phoneCode.toString()+ _phoneNo.text.toString().trim(),
                                                countryISOCode!);
                                            });
                                          } else {
                                            Fiberchat.toast(getTranslated(this.context, 'entervalidmob'));
                                          }
                                        } else{
                                          Fiberchat.toast(getTranslated(context, 'pleaseEnterValidEmail'));
                                        }
                                      } else{
                                        Fiberchat.toast(getTranslated(context, 'emailCannotBeEmpty'));
                                      }
                                    }
                                    else {
                                      Fiberchat.toast(getTranslated(context, 'theUsernameMustBe6Characters'));
                                    }
                                  } else {
                                    Fiberchat.toast(getTranslated(this.context, 'nameem'));
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 18),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: w * 0.95,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '${getTranslated(context, 'agree')} \n',
                                style: TextStyle(
                                  color: DESIGN_TYPE == Themetype.whatsapp ? eocochatBlack : eocochatBlack.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  height: 1.7)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
    ));
  }

  //DEEPAK : //7203820993
  callRegisterApi(String username,String email,String mobile,String countryCode) {
    print('callRegisterApi => username : $username || email : $email || mobile : $mobile || countryCode : $countryCode');
    //username : test
    //email : test@gmail.com
    //mobile : 918979897989
    //countryCode : IN
    APIServices.getRegisterData(username, email, mobile.replaceAll('+', ''), countryCode).then((registerValue) async {
      if(registerValue == null) {
       setState(() {  isLoading = false;  });
        //Eocochat.toast(getTranslated(this.context, 'nameem'));
        print('registerValue null => value : $registerValue');
      }
      else {
        print('registerValue not null => value : $registerValue');
        setState(() {  isLoading = false;  });
        unawaited(Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          Security(
            mobile,
            prefs: widget.prefs!,
            setPasscode: true,
            onSuccess: () async {
              print('<<<<<<<<<< onSuccess 1 >>>>>>>>>>');
              unawaited(Navigator.push(context, new MaterialPageRoute(builder: (context) => FiberchatWrapper())));
              print('<<<<<<<<<< onSuccess 2 >>>>>>>>>>');
              Fiberchat.toast(getTranslated(this.context, 'welcometo') + ' $Appname');
              print('<<<<<<<<<< onSuccess 3 >>>>>>>>>>');
            },
            title: getTranslated(this.context, 'authh'),
          ))));
        await widget.prefs!.setString(Dbkeys.sharedPrefEmail,registerValue.email!);
        await widget.prefs!.setString(Dbkeys.sharedPrefMobile,registerValue.mobile!);
        await widget.prefs!.setString(Dbkeys.sharedPrefUsername,registerValue.username!);
        await widget.prefs!.setString(Dbkeys.sharedPrefCountryCode,registerValue.countryCode!);
        await widget.prefs!.setString(Dbkeys.sharedPrefAccountNumber,registerValue.accountNumber!);
        await widget.prefs!.setString(Dbkeys.sharedPrefUpdatedAt,registerValue.updatedAt!.toString());
        await widget.prefs!.setString(Dbkeys.sharedPrefCreatedAt,registerValue.createdAt!.toString());
        await widget.prefs!.setString(Dbkeys.sharedPrefUserId,registerValue.id!.toString());

      }
    });
  }
}

//___CONSTRUCTORS----

class MySimpleButton extends StatefulWidget {
  final Color? buttoncolor;
  final Color? buttontextcolor;
  final Color? shadowcolor;
  final String? buttontext;
  final double? width;
  final double? height;
  final double? spacing;
  final double? borderradius;
  final Function? onpressed;

  MySimpleButton(
      {this.buttontext,
        this.buttoncolor,
        this.height,
        this.spacing,
        this.borderradius,
        this.width,
        this.buttontextcolor,
        // this.icon,
        this.onpressed,
        // this.forcewidget,
        this.shadowcolor});
  @override
  _MySimpleButtonState createState() => _MySimpleButtonState();
}

class _MySimpleButtonState extends State<MySimpleButton> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: widget.onpressed as void Function()?,
        child: Container(
          alignment: Alignment.center,
          width: widget.width ?? w - 40,
          height: widget.height ?? 50,
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Text(
            widget.buttontext ?? getTranslated(this.context, 'submit'),
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: widget.spacing ?? 2, fontSize: 15, color: widget.buttontextcolor ?? Colors.white),
          ),
          decoration: BoxDecoration(
              color: widget.buttoncolor ?? Colors.primaries as Color?,
              //gradient: LinearGradient(colors: [bgColor, whiteColor]),
              boxShadow: [BoxShadow(color: widget.shadowcolor ?? Colors.transparent, blurRadius: 10, spreadRadius: 2)],
              border: Border.all(color: widget.buttoncolor ?? eocochatgreen),
              borderRadius: BorderRadius.all(Radius.circular(widget.borderradius ?? 5))),
        ));
  }
}

class MobileInputWithOutline extends StatefulWidget {
  final String? initialCountryCode;
  final String? hintText;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final Color? borderColor;
  final Color? buttonTextColor;
  final Color? buttonhintTextColor;
  final TextStyle? hintStyle;
  final String? buttonText;
  final Function(PhoneNumber? phone)? onSaved,onCountryChanged;

  MobileInputWithOutline(
      {this.height,
        this.width,
        this.borderColor,
        this.buttonhintTextColor,
        this.hintStyle,
        this.buttonTextColor,
        this.onSaved,
        this.hintText,
        this.controller,
        this.initialCountryCode,
        this.buttonText,this.onCountryChanged});
  @override
  _MobileInputWithOutlineState createState() => _MobileInputWithOutlineState();
}

class _MobileInputWithOutlineState extends State<MobileInputWithOutline> {
  BoxDecoration boxDecoration(
      {double radius = 5,
        Color bgColor = Colors.white,
        var showShadow = false}) {
    return BoxDecoration(
        color: bgColor,
        boxShadow: showShadow
        ? [BoxShadow(color: eocochatgreen, blurRadius: 10, spreadRadius: 2)]
            : [BoxShadow(color: Colors.transparent)],
    border:Border.all(color: widget.borderColor ?? Colors.grey, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(bottom: 7, top: 5),
          height: widget.height ?? 50,
          width: widget.width ?? MediaQuery.of(context).size.width,
          decoration: boxDecoration(),
          child: IntlPhoneField(
              onCountryChanged: widget.onCountryChanged,
              dropDownArrowColor: widget.buttonhintTextColor ?? Colors.grey[300],
              textAlign: TextAlign.left,
              initialCountryCode: widget.initialCountryCode,
              controller: widget.controller,
              style: TextStyle(
                  height: 1.5,
                  letterSpacing: 1,
                  fontSize: 16.0,
                  color: widget.buttonTextColor ?? Colors.black87,
                  fontWeight: FontWeight.bold),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(3, 15, 8, 0),
                  hintText: widget.hintText ?? getTranslated(this.context, 'enter_mobilenumber'),
                  hintStyle: widget.hintStyle ??
                      TextStyle(
                        letterSpacing: 1,
                        height: 0.0,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w400,
                        color: widget.buttonhintTextColor ?? Colors.grey[300],
                      ),
                  fillColor: Colors.white,
                  filled: true,
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none)),
              onChanged: (phone) {
                widget.onSaved!(phone);
              },
              validator: (v) {
                return null;
              },
              onSaved: widget.onSaved),
        ),
        // Positioned(
        //     left: 110,
        //     child: Container(
        //       width: 1.5,
        //       height: widget.height ?? 48,
        //       color: widget.borderColor ?? Colors.grey,
        //     ))
      ],
    );
  }
}

class InpuTextBox extends StatefulWidget {
  final Color? boxbcgcolor;
  final Color? boxbordercolor;
  final double? boxcornerradius;
  final double? fontsize;
  final double? boxwidth;
  final double? boxborderwidth;
  final double? boxheight;
  final EdgeInsets? forcedmargin;
  final double? letterspacing;
  final double? leftrightmargin;
  final TextEditingController? controller;
  final Function(String val)? validator;
  final Function(String? val)? onSaved;
  final Function(String val)? onchanged;
  final TextInputType? keyboardtype;
  final TextCapitalization? textCapitalization;

  final String? title;
  final String? subtitle;
  final String? hinttext;
  final String? placeholder;
  final int? maxLines;
  final int? minLines;
  final int? maxcharacters;
  final bool? isboldinput;
  final bool? obscuretext;
  final bool? autovalidate;
  final bool? disabled;
  final bool? showIconboundary;
  final Widget? sufficIconbutton;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefixIconbutton;

  InpuTextBox(
      {this.controller,
        this.boxbordercolor,
        this.boxheight,
        this.fontsize,
        this.leftrightmargin,
        this.letterspacing,
        this.forcedmargin,
        this.boxwidth,
        this.boxcornerradius,
        this.boxbcgcolor,
        this.hinttext,
        this.boxborderwidth,
        this.onSaved,
        this.textCapitalization,
        this.onchanged,
        this.placeholder,
        this.showIconboundary,
        this.subtitle,
        this.disabled,
        this.keyboardtype,
        this.inputFormatter,
        this.validator,
        this.title,
        this.maxLines,
        this.autovalidate,
        this.prefixIconbutton,
        this.maxcharacters,
        this.isboldinput,
        this.obscuretext,
        this.sufficIconbutton,
        this.minLines});
  @override
  _InpuTextBoxState createState() => _InpuTextBoxState();
}

class _InpuTextBoxState extends State<InpuTextBox> {
  bool isobscuretext = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isobscuretext = widget.obscuretext ?? false;
    });
  }

  changeobscure() {
    setState(() {
      isobscuretext = !isobscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Align(
      child: Container(
        margin: EdgeInsets.fromLTRB(
            widget.leftrightmargin ?? 8, 5, widget.leftrightmargin ?? 8, 5),
        width: widget.boxwidth ?? w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.white,
              height: widget.boxheight ?? 50,
              // decoration: BoxDecoration(
              //     color: widget.boxbcgcolor ?? Colors.white,
              //     border: Border.all(
              //         color:
              //             widget.boxbordercolor ?? Mycolors.grey.withOpacity(0.2),
              //         style: BorderStyle.solid,
              //         width: 1.8),
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(widget.boxcornerradius ?? 5))),
              child: TextFormField(
                minLines: widget.minLines ?? null,
                maxLines: widget.maxLines ?? 1,
                controller: widget.controller ?? null,
                obscureText: isobscuretext,
                onSaved: widget.onSaved ?? (val) {},
                readOnly: widget.disabled ?? false,
                onChanged: widget.onchanged ?? (val) {},
                maxLength: widget.maxcharacters ?? null,
                validator: widget.validator as String? Function(String?)? ?? null,
                keyboardType: widget.keyboardtype ?? null,
                autovalidateMode: widget.autovalidate == true ? AutovalidateMode.always : AutovalidateMode.disabled,
                inputFormatters: widget.inputFormatter ?? [],
                textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
                style: TextStyle(
                  letterSpacing: widget.letterspacing ?? null,
                  fontSize: widget.fontsize ?? 15,
                  fontWeight: widget.isboldinput == true
                      ? FontWeight.w600
                      : FontWeight.w400,
                  // fontFamily:
                  //     widget.isboldinput == true ? 'NotoBold' : 'NotoRegular',
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    prefixIcon: widget.prefixIconbutton != null
                        ? Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                width: widget.boxborderwidth ?? 1.5,
                                color: widget.showIconboundary == true ||
                                    widget.showIconboundary == null
                                    ? Colors.grey.withOpacity(0.3)
                                    : Colors.transparent),
                          ),
                          // color: Colors.white,
                        ),
                        margin: EdgeInsets.only(left: 2, right: 5, top: 2, bottom: 2),
                        // height: 45,
                        alignment: Alignment.center,
                        width: 50,
                        child: widget.prefixIconbutton != null ? widget.prefixIconbutton : null)
                        : null,
                    suffixIcon: widget.sufficIconbutton != null || widget.obscuretext == true
                        ? Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                width: widget.boxborderwidth ?? 1.5,
                                color: widget.showIconboundary == true ||
                                    widget.showIconboundary == null
                                    ? Colors.grey.withOpacity(0.3)
                                    : Colors.transparent),
                          ),
                          // color: Colors.white,
                        ),
                        margin: EdgeInsets.only(left: 2, right: 5, top: 2, bottom: 2),
                        // height: 45,
                        alignment: Alignment.center,
                        width: 50,
                        child: widget.sufficIconbutton != null
                            ? widget.sufficIconbutton
                            : widget.obscuretext == true
                            ? IconButton(
                            icon: Icon(
                                isobscuretext == true ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: Colors.blueGrey),
                            onPressed: () {
                              changeobscure();
                            })
                            : null)
                        : null,
                    filled: true,
                    fillColor: widget.boxbcgcolor ?? Colors.white,
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(widget.boxcornerradius ?? 1),
                      borderSide: BorderSide(color: widget.boxbordercolor ?? Colors.grey.withOpacity(0.2), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(widget.boxcornerradius ?? 1),
                      borderSide: BorderSide(color: eocochatgreen, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.boxcornerradius ?? 1),
                        borderSide: BorderSide(color: Colors.grey)),
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // labelText: 'Password',
                    hintText: widget.hinttext ?? '',
                    // fillColor: widget.boxbcgcolor ?? Colors.white,

                    hintStyle: TextStyle(letterSpacing: widget.letterspacing ?? 1.5, color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
