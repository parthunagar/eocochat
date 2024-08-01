import 'dart:math';

import 'package:date_format/date_format.dart' as dateformat;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rentors/bloc/BookingProductBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/CityEvent.dart';
import 'package:rentors/event/UploadPhotoEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/DropDownItem.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/model/productdetail/ProductDetailModel.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/UploadPhotoDoneState.dart';
import 'package:rentors/util/DurationTypeEnum.dart';
import 'package:rentors/util/TypeEnum.dart';
import 'package:rentors/widget/AuctionField.dart';
import 'package:rentors/widget/FormFieldDropDownWidget.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';

class BookProductScreen extends StatefulWidget {
  final ProductDetailModel model;

  BookProductScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookProductScreenState();
  }
}

class BookProductScreenState extends State<BookProductScreen> {
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  TimeOfDay selectedTimeFrom = TimeOfDay.now();
  TimeOfDay selectedTimeTo = TimeOfDay.now();
  int _radioValue = 0;

  DropDownItem selectedCity;
  String docdl, docId;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  List<DropDownItem> cityList = List();
  List<DropDownItem> dropdownItems = [
    DurationTypeEnum.HOURS.item,
    DurationTypeEnum.DAYS.item,
    DurationTypeEnum.MONTHS.item
  ];

  DropDownItem durationType;

  void dropdownCallback(DropDownItem item) {
    setState(() {
      durationType = item;
    });
    resetAllDateTime();
  }

  void citySelection(DropDownItem item) {
    setState(() {
      selectedCity = item;
    });
  }

  ProgressDialog dialog;

  BookingProductBloc mBloc = BookingProductBloc();
  Map body = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    // dropdownItems.clear();
    // dropdownItems.add(widget.model.data.details.priceUnit.item);
    durationType = dropdownItems.first;

    mBloc.listen((state) {
      if (state is UploadPhotoDoneState) {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        if (state.typeEnum == TypeEnum.IMAGE1) {
          setState(() {
            docdl = state.home.url;
          });
        } else {
          setState(() {
            docId = state.home.url;
          });
        }
      } else if (state is CityState) {
        cityList.clear();
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
        state.home.data.forEach((element) {
          DropDownItem item = DropDownItem(element, element.cityName);
          cityList.add(item);
        });
        selectedCity = cityList.first;
      } else if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.style(message: S.of(context).uploading);
        dialog.show();
      } else {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mBloc.add(CityEvent());
    });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  _selectDate(BuildContext context, TypeEnum type) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:
            type == TypeEnum.DATE_TO ? selectedDateFrom : selectedDateFrom,
        // Refer step 1
        firstDate: type == TypeEnum.DATE_TO ? selectedDateFrom : DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: config.Colors()
                        .generateMaterialColor(config.Colors().orangeColor)),
              ),
              child: child);
        });

    if (picked != null)
      setState(() {
        if (type == TypeEnum.DATE_FROM) {
          selectedDateFrom = picked;

          fromDateController.text = dateformat.formatDate(selectedDateFrom,
              [dateformat.dd, '-', dateformat.M, '-', dateformat.yyyy]);
        } else {
          selectedDateTo = picked;
          toDateController.text = dateformat.formatDate(selectedDateTo,
              [dateformat.dd, '-', dateformat.M, '-', dateformat.yyyy]);
        }
        selectedTimeFrom = TimeOfDay.now();
        selectedTimeTo = TimeOfDay.now();
        fromTimeController.text = "";
        toTimeController.text = "";
      });
  }

  _selectTime(BuildContext context, TypeEnum type) async {
    var picked = await showTimePicker(
        context: context,
        initialTime:
            type == TypeEnum.TIME_TO ? selectedTimeFrom : TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: config.Colors()
                        .generateMaterialColor(config.Colors().orangeColor)),
              ),
              child: child);
        });
    if (picked != null) {
      if (durationType == DurationTypeEnum.HOURS.item) {
        TimeOfDay currentTime = TimeOfDay.now();
        if (picked.toDouble < currentTime.toDouble) {
          Fluttertoast.showToast(msg: S.of(context).pleaseCheckTime);
          return;
        }
      } else if (durationType == DurationTypeEnum.DAYS.item) {
        if (type == TypeEnum.TIME_TO) {
          if (selectedDateTo.isToday()) {
            TimeOfDay currentTime = TimeOfDay.now();
            if (picked.toDouble < currentTime.toDouble) {
              Fluttertoast.showToast(msg: S.of(context).pleaseCheckTime);
              return;
            }
          }
        } else {
          TimeOfDay currentTime = TimeOfDay.now();
          if (picked.toDouble < currentTime.toDouble) {
            Fluttertoast.showToast(msg: S.of(context).pleaseCheckTime);
            return;
          }
        }
      }

      if (durationType == DurationTypeEnum.HOURS.item &&
          type == TypeEnum.TIME_TO) {
        if (picked.toDouble > selectedTimeFrom.toDouble) {
// NO need to do anything
        } else {
          Fluttertoast.showToast(msg: S.of(context).pleaseCheckTime);
          return;
        }
      }
      setState(() {
        if (type == TypeEnum.TIME_FROM) {
          selectedTimeFrom = picked;
          fromTimeController.text = selectedTimeFrom.format(context);
        } else {
          selectedTimeTo = picked;
          toTimeController.text = selectedTimeTo.format(context);
        }
      });
    }
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BlocProvider(
          create: (BuildContext context) => BookingProductBloc(),
          child: BlocBuilder<BookingProductBloc, BaseState>(
              bloc: mBloc,
              builder: (BuildContext context, BaseState state) {
                if (state is LoadingState) {
                  return ProgressIndicatorWidget();
                }
                return SingleChildScrollView(
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          S.of(context).durationType,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: FormFieldDropDownWidget(
                            hint: S.of(context).from,
                            dropdownItems: dropdownItems,
                            callback: dropdownCallback,
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          S.of(context).selectDate,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: AuctionField(
                            mController: fromDateController,
                            hint: S.of(context).from,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context, TypeEnum.DATE_FROM);
                            },
                          )),
                      Visibility(
                        visible: durationType.key == PriceUnit.DAY,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 10, bottom: 10, right: 10),
                            child: AuctionField(
                                mController: toDateController,
                                hint: S.of(context).to,
                                readOnly: true,
                                onTap: () {
                                  _selectDate(context, TypeEnum.DATE_TO);
                                })),
                      ),
                      Visibility(
                          visible: durationType.key != PriceUnit.MONTH,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  S.of(context).selectTime,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: AuctionField(
                                      mController: fromTimeController,
                                      hint: S.of(context).from,
                                      readOnly: true,
                                      onTap: () {
                                        _selectTime(
                                            context, TypeEnum.TIME_FROM);
                                      })),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 10, bottom: 10, right: 10),
                                  child: AuctionField(
                                      mController: toTimeController,
                                      hint: S.of(context).to,
                                      readOnly: true,
                                      onTap: () {
                                        _selectTime(context, TypeEnum.TIME_TO);
                                      })),
                            ],
                          )),
                      Visibility(
                          visible: durationType.key == PriceUnit.MONTH,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    S.of(context).period,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 10, bottom: 10, right: 10),
                                    child: AuctionField(
                                      hint: S.of(context).period,
                                      mController: periodController,
                                      inputType: TextInputType.number,
                                    ))
                              ])),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          S.of(context).name,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: AuctionField(
                            hint: S.of(context).enterName,
                            mController: nameController,
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          S.of(context).address,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: AuctionField(
                            hint: S.of(context).enterAddress,
                            mController: addressController,
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          S.of(context).city,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: FormFieldDropDownWidget(
                            hint: S.of(context).city,
                            dropdownItems: cityList,
                            callback: citySelection,
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          S.of(context).state,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: AuctionField(
                            hint: "",
                            mController: stateController,
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          S.of(context).pincode,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: AuctionField(
                            hint: "",
                            mController: pinCodeController,
                            inputType: TextInputType.number,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text(S.of(context).pickup),
                          Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text(S.of(context).delivery),
                          Radio(
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text(S.of(context).other),
                        ],
                      ),
                      Visibility(
                          visible: widget.model.data.verificationRequired,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, bottom: 10, right: 10, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).uploadDocuments,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    S
                                        .of(context)
                                        .uploadNationalIdentityCardUploadAddressProofother,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            height: 80,
                                            child: InkWell(
                                              onTap: () {
                                                _showPicker(
                                                    context, TypeEnum.IMAGE1);
                                              },
                                              child: docdl == null
                                                  ? SvgPicture.asset(
                                                      "assets/img/upload_second.svg",
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.network(docdl),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 90,
                                            height: 80,
                                            child: InkWell(
                                                onTap: () {
                                                  _showPicker(
                                                      context, TypeEnum.IMAGE2);
                                                },
                                                child: docId == null
                                                    ? SvgPicture.asset(
                                                        "assets/img/upload_second.svg",
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.network(docId)),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 10,
                                          bottom: 10,
                                          right: 10,
                                          top: 10),
                                      child: Row(
                                        children: [
                                          Text(S.of(context).drivingLicenseEtc)
                                        ],
                                      ))
                                ],
                              ))),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 10, bottom: 10, right: 10, top: 10),
                          child: RentorRaisedButton(
                            onPressed: () {
                              showPreview();
                            },
                            child: Text(
                              S.of(context).next,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          ))
                    ],
                  )),
                );
              })),
      appBar: AppBar(
        title: Text(S.of(context).bookProduct),
        elevation: 0,
      ),
    );
  }

  Map generateBody(fromDate, toDate, timeFrom, timeTo, name, address, state,
      pinCode, int period) {
    body["details"] = widget.model;
    body["product_id"] = widget.model.data.id;
    body["date_from"] = fromDate;
    body["date_to"] = toDate;
    body["time_from"] = timeFrom;
    body["time_to"] = timeTo;
    body["name"] = name;
    body["address"] = address;
    body["city"] = selectedCity.value;
    body["state"] = state;
    body["period"] = period;
    body["pincode"] = pinCodeController.text;
    body["payable_amount"] = payableAmount(selectedTimeFrom, selectedTimeTo,
        selectedDateFrom, selectedDateTo, period);
    body["price_unit"] =
        priceUnitValues.reverse[widget.model.data.details.priceUnit];
    if (docdl == null) {
      body["doc_dl"] = "";
      body["doc_id"] = "";
    } else {
      body["doc_dl"] = docdl;
      body["doc_id"] = docId;
    }
    return body;
  }

  void showPreview() {
    var fromDate = fromDateController.text.toString().trim();

    var timeFrom = fromTimeController.text.toString().trim();
    var timeTo = toTimeController.text.toString().trim();
    var name = nameController.text.toString().trim();
    var address = addressController.text.toString().trim();
    var state = stateController.text.toString().trim();
    var pinCode = pinCodeController.text.toString().trim();
    var period = 0;
    if (periodController.text.toString().length > 0) {
      period = int.parse(periodController.text.toString().trim());
    }
    if (durationType == DurationTypeEnum.HOURS.item) {
      selectedDateTo = selectedDateFrom;
    } else if (durationType == DurationTypeEnum.MONTHS.item) {
      selectedDateTo = Jiffy(selectedDateFrom).add(months: period) as DateTime;
    }
    var toDate = dateformat.formatDate(selectedDateTo,
        [dateformat.dd, '-', dateformat.M, '-', dateformat.yyyy]);

    if (fromDate.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).fromDateShouldNotBeEmpty);
      return;
    }
    if (toDate.isEmpty && durationType == DurationTypeEnum.MONTHS.item) {
      Fluttertoast.showToast(msg: S.of(context).toDateShouldNotBeEmpty);
      return;
    }
    if (timeFrom.isEmpty && durationType != DurationTypeEnum.MONTHS.item) {
      Fluttertoast.showToast(msg: S.of(context).fromTimeShouldNotBeEmpty);
      return;
    }
    if (timeTo.isEmpty && durationType != DurationTypeEnum.MONTHS.item) {
      Fluttertoast.showToast(msg: S.of(context).toTimeShouldNotBeEmpty);
      return;
    }
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).nameShouldNotBeEmpty);
      return;
    }
    if (address.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).addressShouldNotBeEmpty);
      return;
    }
    if (state.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).stateShouldNotBeEmpty);
      return;
    }
    if (pinCode.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pincodeShouldNotBeEmpty);
      return;
    }
    if (durationType == DurationTypeEnum.MONTHS.item) {
      if (period == 0) {
        Fluttertoast.showToast(msg: S.of(context).pleaseAddPeriod);
        return;
      }
    }
    if (widget.model.data.verificationRequired) {
      if (docId == null || docdl == null) {
        Fluttertoast.showToast(msg: S.of(context).pleaseUploadDocument);
        return;
      }
    }
    Navigator.of(context).pushNamed("/preview",
        arguments: generateBody(fromDate, toDate, timeFrom, timeTo, name,
            address, state, pinCode, period));
  }

  void resetAllDateTime() {
    selectedDateFrom = DateTime.now();
    selectedDateTo = DateTime.now();
    selectedTimeTo = TimeOfDay.now();
    selectedTimeFrom = TimeOfDay.now();
    fromDateController.text = "";
    toDateController.text = "";
    toTimeController.text = "";
    fromTimeController.text = "";
  }

  int payableAmount(TimeOfDay timefrom, TimeOfDay timeTo, DateTime dateTimeFrom,
      DateTime dateTimeTo, int period) {
    if (durationType == DurationTypeEnum.HOURS.item) {
      return totalHrPrice(timefrom, timeTo).round() < 0
          ? 0
          : totalHrPrice(timefrom, timeTo).round();
    } else if (durationType == DurationTypeEnum.MONTHS.item) {
      return totalMonthPrice(dateTimeFrom, period).round() < 0
          ? 0
          : totalMonthPrice(dateTimeFrom, period).round();
    } else {
      return totalDayPrice(dateTimeFrom, dateTimeTo).round() < 0
          ? 0
          : totalDayPrice(dateTimeFrom, dateTimeTo).round();
    }
  }

  double totalMonthPrice(DateTime datefrom, int period) {
    double totalHrPrice = 0;
    try {
      DateTime dateTo = datefrom.add(Duration(days: period));
      int totalDay = max(0, dateTo.difference(datefrom).inDays);
      double totalHr = totalDay.toDouble() * 24 * 30;
      double minHr = minHrs();
      if (minHr > totalHr) {
        totalHrPrice = double.parse(widget.model.data.details.minBookingAmount);
      } else {
        totalHrPrice = totalHr * hrPrice();
      }
    } catch (Exception) {}
    return totalHrPrice;
  }

  double totalDayPrice(DateTime datefrom, DateTime dateTo) {
    double totalHrPrice = 0;
    try {
      int totalDay = max(0, dateTo.difference(datefrom).inDays);
      double totalHr = totalDay.toDouble() * 24;
      double minHr = minHrs();
      if (minHr > totalHr) {
        totalHrPrice = double.parse(widget.model.data.details.minBookingAmount);
      } else {
        totalHrPrice = totalHr * hrPrice();
      }
    } catch (Exception) {}
    return totalHrPrice;
  }

  double totalHrPrice(TimeOfDay timefrom, TimeOfDay timeTo) {
    double totalHrPrice = 0;
    try {
      double diff = timeTo.toDouble - timefrom.toDouble;
      double totalHr = max(0, diff);
      double minHr = minHrs();
      if (minHr > totalHr) {
        totalHrPrice = double.parse(widget.model.data.details.minBookingAmount);
      } else {
        totalHrPrice = totalHr * hrPrice();
      }
    } catch (Exception) {}
    return totalHrPrice;
  }

  double minHrs() {
    double minHr;
    var unit = widget.model.data.details.priceUnit;
    if (unit == PriceUnit.DAY) {
      minHr = 24;
    } else if (unit == PriceUnit.MONTH) {
      double temp = 24.toDouble() * 30.toDouble();
      minHr = temp;
    } else {
      minHr = 1;
    }
    return minHr;
  }

  double hrPrice() {
    var unit = widget.model.data.details.priceUnit;
    var price = double.parse(widget.model.data.details.price);
    double hrPrice;
    if (unit == PriceUnit.DAY) {
      hrPrice = price / 24;
    } else if (unit == PriceUnit.MONTH) {
      var temp = price / 30;
      hrPrice = temp / 24;
    } else {
      hrPrice = price;
    }
    return hrPrice;
  }
}
