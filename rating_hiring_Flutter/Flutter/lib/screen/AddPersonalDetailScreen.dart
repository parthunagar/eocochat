import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/AddProductBloc.dart';
import 'package:rentors/bloc/BookingProductBloc.dart';
import 'package:rentors/bloc/OTPVerifiedBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/AddProductEvent.dart';
import 'package:rentors/event/CityEvent.dart';
import 'package:rentors/event/SendOTPEvent.dart';
import 'package:rentors/event/UserDetailEvent.dart';
import 'package:rentors/event/VerifyOTPEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/AddProductModel.dart';
import 'package:rentors/model/DropDownItem.dart';
import 'package:rentors/model/MyProductModel.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/DoneState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UserDetailState.dart';
import 'package:rentors/util/ImagePicked.dart';
import 'package:rentors/util/TypeEnum.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/AuctionField.dart';
import 'package:rentors/widget/FormFieldDropDownWidget.dart';
import 'package:rentors/widget/PinEntryTextField.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:rentors/widget/UploadPhotoWidget.dart';

class AddPersonalDetailScreen extends StatefulWidget {
  final AddProductModel model;
  final MyProduct previousDetails;

  AddPersonalDetailScreen(this.model, this.previousDetails);

  @override
  State<StatefulWidget> createState() {
    return AddPersonalDetailScreenState();
  }
}

class AddPersonalDetailScreenState extends State<AddPersonalDetailScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  ProgressDialog dialog;
  AddProductBloc mBloc = AddProductBloc();
  BookingProductBloc bookingProductBloc = BookingProductBloc();
  OTPVerifiedBloc otpVerifiedBloc = OTPVerifiedBloc();
  List<DropDownItem> cityList = List();
  bool verifiedNumber = false;
  List<ImagePicked> imagePickedList = List();
  DropDownItem selectedCity;

  String countryCode = "+91";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mBloc.add(UserDetailEvent());
    mBloc.listen((state) {
      if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.show();
      }else if (state is UserDetailState) {
        nameController.text=state.home.data.name;
        addressController.text=state.home.data.address;
        mobileNumberController.text=state.home.data.mobile;
        String cityName=state.home.data.city;
        if(cityList.isNotEmpty){
          cityList.forEach((DropDownItem element) {
            if(element.value==cityName){
              selectedCity= element;
            }
          });
        }
        setState(() {

        });
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state is DoneState) {
          Fluttertoast.showToast(msg: state.home.message);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      }
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
          verifiedNumber = true;
          addComplaint();
        } else if (state is OtpState) {
          showInputDialog(state.mobileNumber, state.verificationId);
        } else if (state is ErrorState) {
          Fluttertoast.showToast(msg: state.home);
        }
      }
    });
    bookingProductBloc.listen((state) {
      if (state is CityState) {
        state.home.data.forEach((element) {
          DropDownItem item = DropDownItem(element, element.cityName);
          cityList.add(item);
        });
        selectedCity = cityList.first;
        _initEditUI();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bookingProductBloc.add(CityEvent());
    });
  }

  void citySelection(DropDownItem item) {
    selectedCity = item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
            create: (BuildContext context) => BookingProductBloc(),
            child: BlocBuilder<BookingProductBloc, BaseState>(
                bloc: bookingProductBloc,
                builder: (BuildContext context, BaseState state) {
                  if (state is LoadingState) {
                    return ProgressIndicatorWidget();
                  } else {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuctionField(
                            hint: S.of(context).name,
                            mController: nameController,
                            readOnly: true,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: AuctionField(
                              hint: S.of(context).address,
                              mController: addressController,
                              readOnly: true,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: AuctionField(
                                hint: 'City',
                                mController: TextEditingController()..text=selectedCity.value,
                                readOnly: true,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              autofocus: false,
                              controller: mobileNumberController,
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              decoration: InputDecoration(
                                  labelText: S.of(context).mobileNumber,
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: S.of(context).mobileNumber,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).buttonColor),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).buttonColor)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).buttonColor)),
                                  prefixIcon: CountryCodePicker(
                                    onChanged: (code) {
                                      countryCode = code.dialCode;
                                    },
                                    flagWidth: 20,
                                    initialSelection: countryCode,
                                    showFlag: true,
                                    showFlagDialog: true,
                                    comparator: (a, b) =>
                                        b.name.compareTo(a.name),
                                    //Get the country information relevant to the initial selection
                                  )),
                            ),
                          ),
                         /* Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                UploadPhotoWidget(S.of(context).uploadDocument,
                                    TypeEnum.IMAGE1, imageSelectionCallback),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    height: 150,
                                    width: config.App(context).appWidth(40),
                                    child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(width: 10);
                                      },
                                      itemCount: imagePickedList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Stack(
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              height: 120,
                                              child: OptimizedCacheImage(
                                                fit: BoxFit.fill,
                                                imageUrl: imagePickedList[index]
                                                    .imageUrl,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  imagePickedList
                                                      .removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                width: 120,
                                                height: 120,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                alignment: Alignment.topRight,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ))
                              ],
                            ),
                          ),*/
                          BlocProvider(
                              create: (BuildContext context) => AddProductBloc(),
                              child: BlocBuilder<AddProductBloc, BaseState>(
                                  bloc: mBloc,
                                  builder:
                                      (BuildContext context, BaseState state) {
                                    return Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
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
                    );
                  }
                })),
        appBar: AppBar(
          title: Text(S.of(context).addPersonalDetails),
        ));
  }

  void imageSelectionCallback(String url, TypeEnum typeEnum) {
    setState(() {
      imagePickedList.add(ImagePicked(url));
    });
  }

  void addComplaint() {
    var nameText = nameController.text.trim();
    var address = addressController.text.trim();
    var city = selectedCity.value;
    var mobileNumner = mobileNumberController.text.trim();
    if (nameText.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseAddName);
      return;
    }
    if (address.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseSelectAddress);
      return;
    }
    if (city.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseSelectCity);
      return;
    }
    if (mobileNumner.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseAddValidMobileNumber);
      return;
    }
    /*if (imagePickedList.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseSelectDocument);
      return;
    }*/
    var details = widget.model;
    details.details.name = nameText;
    details.details.city = city;
    details.details.city_id = selectedCity.key.id;
    details.details.address = address;
    details.details.mobileNo = countryCode + mobileNumner;
    details.details.document =
        imagePickedList.map((e) => e.imageUrl).toList().toString();
   /* if (!verifiedNumber) {
      otpVerifiedBloc.add(SendOTPEvent(countryCode, mobileNumner));
    } else {
    }*/
    mBloc.add(AddProductEvent(details, widget.previousDetails));
  }

  void showInputDialog(String mobileNumber, String verificationId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: config.App(context).appHeight(30),
              width: config.App(context).appWidth(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      S.of(context).weSentYouACodeToVerifyYourPhoneNumber,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        mobileNumber,
                        style: TextStyle(
                            color: config.Colors().orangeColor, fontSize: 15),
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: PinEntryTextField(
                          fieldWidth: 25.0,
                          fields: 6,
                          onSubmit: (value) {
                            if (value.length == 6) {
                              otpVerifiedBloc
                                  .add(VerifyOTPEvent(verificationId, value));
                              Navigator.of(context).pop();
                            }
                          })),
                ],
              ),
            ),
          );
        });
  }

  void _initEditUI() {
    if (widget.previousDetails != null) {
      nameController.text = widget.previousDetails.details.name;
      addressController.text = widget.previousDetails.details.address;
      // var city = selectedCity.value;
      // mobileNumberController.text = widget.previousDetails.details.mobileNo;
      setState(() {
        imagePickedList.addAll(
            Utils.getAllImages(widget.previousDetails.details.document)
                .map((e) {
          return ImagePicked(e);
        }).toList());
      });
    }
    selectedCity = cityList.firstWhere(
        (element) => element.value == widget.previousDetails.details.city);
  }
}
