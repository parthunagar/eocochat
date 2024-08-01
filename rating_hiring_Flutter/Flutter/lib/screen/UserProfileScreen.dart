import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentors/bloc/OTPVerifiedBloc.dart';
import 'package:rentors/bloc/UserDetailBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/CityEvent.dart';
import 'package:rentors/event/SendOTPEvent.dart';
import 'package:rentors/event/UpdateUserDetailEvent.dart';
import 'package:rentors/event/UploadPhotoEvent.dart';
import 'package:rentors/event/UserDetailEvent.dart';
import 'package:rentors/event/VerifyOTPEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/DropDownItem.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UploadPhotoDoneState.dart';
import 'package:rentors/state/UserDetailState.dart';
import 'package:rentors/util/TypeEnum.dart';
import 'package:rentors/widget/AuctionFormField.dart';
import 'package:rentors/widget/FormFieldDropDownWidget.dart';
import 'package:rentors/widget/PinEntryTextField.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:rentors/widget/UploadPhotoWidget.dart';
import 'TermCondition.dart';


class UserProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserProfileScreenState();
  }
}

class UserProfileScreenState extends RentorState<UserProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  List<DropDownItem> cityList = List();
  UserDetailBloc mBloc;
  String countryCode = "+1";
  String imagerUrl,imagerUrl2,imagerUrl3;
  bool isLoading = false;
  OTPVerifiedBloc otpVerifiedBloc = OTPVerifiedBloc();
  DropDownItem selectedCityDrop;

  ProgressDialog dialog;
  String oldCountryCode;
  String phone;
  String isInsurance='no';
  bool termCondition=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagerUrl = "";
    imagerUrl2 = "";
    imagerUrl3 = "";

    mBloc = UserDetailBloc();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mBloc.add(CityEvent());
      mBloc.listen((state) {
        if (state is ProgressDialogState) {
          dialog = ProgressDialog(context, isDismissible: true);
          dialog.show();
        }
        else if (state is CityState) {
          cityList.clear();
          if (dialog != null && dialog.isShowing()) {
            dialog.hide();
          }
          state.home.data.forEach((element) {
            DropDownItem item = DropDownItem(element, element.cityName);
            cityList.add(item);
            selectedCityDrop=cityList.first;
          });

        }else if (state is UploadPhotoDoneState) {
          if (dialog != null && dialog.isShowing()) {
            dialog.hide();
          }
          if (state.typeEnum == TypeEnum.IMAGE1) {
            setState(() {
              imagerUrl = state.home.url;
            });
          } else if (state.typeEnum == TypeEnum.IMAGE2) {
            setState(() {
              imagerUrl2 = state.home.url;
            });
          }
        } else {
          if (dialog != null && dialog.isShowing()) {
            dialog.hide();
          }
          if (state is DoneState) {
            showConfirmDialog();
          }
          else if (state is UserDetailState) {
            nameController.text = state.home.data.name;
            lastnameController.text = state.home.data.lastName;
            phoneController.text = state.home.data.mobile!="NA"?state.home.data.mobile:"";
            addressController.text = state.home.data.address!="NA"?state.home.data.address:"";
            emailController.text = state.home.data.email!="NA"?state.home.data.email:"";
            stateController.text = state.home.data.state!="NA"?state.home.data.state:"";
            pinCodeController.text = state.home.data.pincode!="NA"?state.home.data.pincode:"";
            String selectedCity = state.home.data.city!="NA"?state.home.data.city:"";
            if(cityList.isNotEmpty){
              cityList.forEach((DropDownItem element) {
                if(element.value==selectedCity){
                  selectedCityDrop= element;
                }
              });
            }
            oldCountryCode =
                "+" + state.home.data.countryCode.replaceAll("+", "");
            phone = state.home.data.mobile;
            countryCode = oldCountryCode;
            imagerUrl = state.home.data.profilePic;
            imagerUrl2 = state.home.data.national_id_proof;

            setState(() {
              isLoading = false;
            });
          }
        }
      });
      setState(() {
        isLoading = true;
      });
      mBloc.add(UserDetailEvent());
    });
    otpVerifiedBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.show();
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state is VerifiedOTPState) {
          _updateProfile();
        } else if (state is OtpState) {
          showInputDialog(state.mobileNumber, state.verificationId);
        } else if (state is ErrorState) {
          Fluttertoast.showToast(msg: state.home);
        }
      }
    });
  }

  void save() {
    var name = nameController.text.toString().trim();
    var lastName = lastnameController.text.toString().trim();
    var phne = phoneController.text.trim();
    var address = addressController.text.trim();
    var emailAddress = emailController.text.trim();
    var state = stateController.text.trim();
    var pincode = pinCodeController.text.trim();
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterName);
    }else if (lastName.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Last Name');
    } else if (phne.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterPhoneNumber);
    } else if (address.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterAddress);
    } else if (emailAddress.isEmpty || !EmailValidator.validate(emailAddress)) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterValidEmailAddress);
    } else if (state.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter State');
    }else if (pincode.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Pincode');
    }else if (imagerUrl.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Upload Selfie as mentioned');
    }else if (imagerUrl2.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Upload Selfie with licence as mentioned');
    }else {
      if (phone != phne || countryCode != oldCountryCode) {
        otpVerifiedBloc.add(SendOTPEvent(countryCode, phne));
      } else {
        _updateProfile();
      }
    }
  }

  void _updateProfile() {
    var name = nameController.text.toString().trim();
    var last_name = lastnameController.text.toString().trim();
    var phne = phoneController.text.trim();
    var address = addressController.text.trim();
    var emailAddress = emailController.text.trim();
    var state = stateController.text.trim();
    var pincode = pinCodeController.text.trim();
    var body = Map();
    body["name"] = name;
    body["last_name"] = last_name;
    body["address"] = address;
    body["mobile"] = phne;
    body["email"] = emailAddress;
    body["country_code"] = countryCode;
    body["profile_pic"] = imagerUrl;
    body["pincode"] = pincode;
    body["state"] = state;
    body["city"] = selectedCityDrop.value;
    body["national_id_proof"] = imagerUrl2;
    mBloc.add(UpdateUserDetailEvent(body));
  }

  void showInputDialog(String mobileNumber, String verificationId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: config.Colors().accentDarkColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).weSentYouACodeToVerifyYourPhoneNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      mobileNumber,
                      style: TextStyle(
                          color: config.Colors().accentDarkColor, fontSize: 15),
                    )),
                Container(
                    margin: EdgeInsets.all(10),
                    child: PinEntryTextField(
                        fieldWidth: 35.0,
                        fields: 6,
                        onSubmit: (value) {
                          if (value.length == 6) {
                            otpVerifiedBloc
                                .add(VerifyOTPEvent(verificationId, value));
                            Navigator.of(context).pop();
                          }
                        })),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: InheritedStateContainer(
        state: this,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: isLoading ? ProgressIndicatorWidget() : box(),
            appBar: AppBar(
              title: Text(S.of(context).userProfile),
            )),
      ),
    );
  }
  void citySelection(DropDownItem item) {
    setState(() {
      selectedCityDrop = item;
    });
  }

  void imageSelectionCallback(String url, TypeEnum typeEnum) {

  }

  Widget box() {
    return Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UploadPhotoWidget("", TypeEnum.IMAGE1, imageSelectionCallback,
                        child: Column(
                          children: [
                            Card(
                              elevation: 10,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: config.Colors().white),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:AssetImage('assets/img/avatar.png'),
                                  foregroundImage: NetworkImage(imagerUrl),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Tab to change profile pic",
                                style: TextStyle(fontSize: 15,color: config.Colors().accentDarkColor),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: AuctionFormField('First Name',
                    mController: nameController),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: AuctionFormField('Last Name',
                    mController: lastnameController),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  autofocus: false,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: S.of(context).mobileNumber,
                      labelStyle: TextStyle(color: Theme.of(context).buttonColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: S.of(context).mobileNumber,
                      hintStyle: TextStyle(color: Theme.of(context).buttonColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Theme.of(context).buttonColor)),
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Theme.of(context).buttonColor)),
                      enabledBorder:OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Theme.of(context).buttonColor)),
                      prefixIcon: CountryCodePicker(
                        flagWidth: 20,
                        textStyle: TextStyle(
                            color: config.Colors().accentDarkColor
                        ),
                        onChanged: (country) {
                          countryCode = country.dialCode;
                        },
                        initialSelection: countryCode,
                        showFlag: true,
                        showFlagDialog: true,
                        comparator: (a, b) => b.name.compareTo(a.name),
                        //Get the country information relevant to the initial selection
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: AuctionFormField(S.of(context).email,
                    mController: emailController),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: AuctionFormField(S.of(context).address,
                    mController: addressController),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  S.of(context).city,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                  child: FormFieldDropDownWidget(
                    hint: S.of(context).city,
                    dropdownItems: cityList,
                    callback: citySelection,
                    selected: selectedCityDrop,
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: AuctionFormField(S.of(context).state,
                    mController: stateController),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: AuctionFormField(S.of(context).pincode,
                    mController: pinCodeController),
              ),
              SizedBox(height: 10,),
              Text('Selfie with National ID Proof.',style: TextStyle(
                fontSize: 16,
              ),),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  _showPicker(context, TypeEnum.IMAGE2);
                },
                child: SizedBox(
                  width: 90,
                  height: 80,
                  child: imagerUrl2.length<3
                      ? SvgPicture.asset(
                    "assets/img/upload_second.svg",
                    fit: BoxFit.fill,
                  )
                      : Image.network(imagerUrl2),
                ),
              ),

              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10),
                child: Row(
                  children: [
                    Checkbox(value: termCondition, onChanged: (b){
                      setState(() {
                        termCondition=b;
                      });
                    },
                    activeColor: config.Colors().mainDarkColor,),
                    Expanded(child: TermCondition())
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: RentorRaisedButton(
                  child: Text(
                    S.of(context).save,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if(termCondition) {
                      save();
                    }else{
                      Fluttertoast.showToast(msg: 'Accept term & condition');
                    }
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  _imgFromCamera(TypeEnum typeEnum) async {
    var picker = ImagePicker();
    var image =
    await picker.getImage(source: ImageSource.camera, imageQuality: 70);
    setState(() {
      if (typeEnum == TypeEnum.IMAGE1) {
        mBloc.add(UploadPhotoEvent(image, typeEnum));
      } else {
        mBloc.add(UploadPhotoEvent(image, typeEnum));
      }
    });
  }

  _imgFromGallery(TypeEnum typeEnum) async {
    var picker = ImagePicker();
    var image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 70);
    setState(() {
      if (typeEnum == TypeEnum.IMAGE1) {
        mBloc.add(UploadPhotoEvent(image, typeEnum));
      } else {
        mBloc.add(UploadPhotoEvent(image, typeEnum));
      }
    });
  }

  void _showPicker(context, TypeEnum typeEnum) {
    showModalBottomSheet(
        context: context,
        backgroundColor: config.Colors().white,
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

  @override
  void update() {}

  @override
  void updateView(item) {
    super.updateView(item);
    setState(() {
      isLoading = true;
      imagerUrl = item;
      isLoading = false;
    });
  }
  void showConfirmDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                  backgroundColor: config.Colors().mainDarkColor,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: config.Colors().mainDarkColor,width: 2),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Your profile has been successfully submitted for review, we will notify you once your profile is approved.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: config.Colors().white,
                                  fontFamily: 'open'),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            child: RentorRaisedButton(
                              onPressed: () =>{
                                Navigator.of(context).pop(),
                                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false)
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
            );
          });
        });
  }
}
