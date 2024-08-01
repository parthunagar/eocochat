import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/BookingProductBloc.dart';
import 'package:rentors/bloc/CategoryListBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/event/CategoryListEvent.dart';
import 'package:rentors/event/ChangeSubCategory.dart';
import 'package:rentors/event/SubCategoryEvent.dart';
import 'package:rentors/event/UploadPhotoEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/AddProductModel.dart';
import 'package:rentors/model/DropDownItem.dart';
import 'package:rentors/model/FeatureSubscriptionList.dart';
import 'package:rentors/model/MyProductModel.dart';
import 'package:rentors/model/UserDetail.dart';
import 'package:rentors/model/category/CategoryList.dart' as Category;
import 'package:rentors/model/home/HomeModel.dart' as home;
import 'package:rentors/screen/MapScreen.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CategoryListState.dart';
import 'package:rentors/state/ChangeSubCategoryState.dart';
import 'package:rentors/state/CheckUserState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SubCategoryListState.dart';
import 'package:rentors/state/UploadPhotoDoneState.dart';
import 'package:rentors/util/DurationTypeEnum.dart';
import 'package:rentors/util/ImagePicked.dart';
import 'package:rentors/util/TypeEnum.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/AuctionField.dart';
import 'package:rentors/widget/AuctionFormField.dart';
import 'package:rentors/widget/FormFieldDropDownWidget.dart';
import 'package:rentors/widget/ProgressDialog.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';

class CreateProductScreenWidget extends StatefulWidget {
  final MyProduct myProduct;

  CreateProductScreenWidget(this.myProduct);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CreateProductScreenWidgetState();
  }
}

class CreateProductScreenWidgetState extends State<CreateProductScreenWidget> {
  // List<DropDownItem> categoryList = List();
  List<DropDownItem> subCategoryList = List();
  List<DropDownItem> categoryList = List();
  CategoryListBloc mCategoryBloc = CategoryListBloc();
  BookingProductBloc bookingBloc = BookingProductBloc();
  DropDownItem selectedCategory;
  DropDownItem selectedSubCategory;

  List<ImagePicked> imagePickedList = List();
  ProgressDialog dialog;
  Map<String, TextEditingController> dynamicController = Map();
  Map<String, String> labels = Map();
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController mini = TextEditingController();
  TextEditingController description = TextEditingController();
  List<DropDownItem> durationItems = [
    DurationTypeEnum.HOURS.item,
    DurationTypeEnum.DAYS.item,
    DurationTypeEnum.MONTHS.item
  ];
  String selectedLocation='Product Location';
  LatLng latlon;
  DropDownItem selectedDuration;
  Feature selectedFeature;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSubCategory = null;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mCategoryBloc.add(CategoryListEvent());
    });
    selectedDuration = durationItems.first;
    mCategoryBloc.listen((state) {
      print("Category bloc");
      if (state is CategoryListState) {
        categoryList.clear();
        state.categoryList.data.forEach((element) {
          categoryList.add(DropDownItem(element, element.name));
        });
        var category = state.categoryList.data.first;
        category.subCategory.forEach((element) {
          subCategoryList.add(DropDownItem(element, element.name));
        });
        selectedCategory = categoryList.first;
        selectedSubCategory = subCategoryList.first;
        initProductEditUI();
        if (state.checkuser != null) {
          UserDetail detail = state.userDetail as UserDetail;
          if(detail.data.is_verified!="1"){
            showConfirmDialog(detail);
          }else
          if (!state.checkuser.isSubscribed) {
            if (state.checkuser.isAddedProductCount < 3) {
              showSubScriptionDialog(state.checkuser.data);
            } else {
              showFeatureListDialog(state.checkuser.data);
            }
          }
        }
      } else if (state is SubCategoryListState) {
        subCategoryList.clear();
        state.categoryList.forEach((element) {
          subCategoryList.add(DropDownItem(element, element.name));
        });

        if (subCategoryList.isEmpty) {
          subCategoryList.add(DropDownItem(null, "Subcategory"));
        }

        selectedSubCategory = subCategoryList.first;
      } else if (state is ChangeSubCategoryState) {
        selectedSubCategory = state.category;
      }
    });

    bookingBloc.listen((state) {
      print("Booking BLOC $state");
      if (state is UploadPhotoDoneState) {
        if (dialog != null && dialog.isShowing()) {
          dialog.hide();
        }

        setState(() {
          imagePickedList.add(ImagePicked(state.home.url));
        });
      }
      else if (state is ProgressDialogState) {
        dialog = ProgressDialog(context, isDismissible: true);
        dialog.style(message: S.of(context).uploading);
        dialog.show();
      }
    });
  }
  void showConfirmDialog(model) {
    bool isVerify = model.data.email.length > 3 &&
        model.data.mobile.length > 3;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                insetPadding: EdgeInsets.all(10),
                backgroundColor: config.Colors().mainDarkColor,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: config.Colors().white
                  ),
                  margin: EdgeInsets.all(2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(left: 5,top: 5),
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.clear,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }),
                          ),
                          Center(child: Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 5),
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Confirmation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: config.Colors().accentDarkColor),
                            ),
                          ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        alignment: Alignment.topCenter,
                        child: Text(
                          isVerify?'Please wait till your profile is approved':'Please complete your profile to add/book products on Rentors Plus.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, color: config.Colors().accentDarkColor),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        child: RentorRaisedButton(
                          onPressed: () {
                            if(isVerify){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }else{
                              Navigator.of(context).pushNamed("/profile");
                            }
                          },child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          });
        });
  }

  void initProductEditUI() {
    if (widget.myProduct != null) {
      productName.text = widget.myProduct.details.productName;
      price.text = widget.myProduct.details.price;
      mini.text = widget.myProduct.details.minBookingAmount;
      description.text = widget.myProduct.details.description;

      setState(() {
        imagePickedList.addAll(
            Utils.getAllImages(widget.myProduct.details.allImages).map((e) {
          return ImagePicked(e);
        }).toList());
        selectedDuration = widget.myProduct.details.priceUnit.item;
        selectedCategory = categoryList.singleWhere((element) {
          return element.key.name == widget.myProduct.details.category;
        });
        subCategoryList.clear();
        selectedCategory.key.subCategory.forEach((element) {
          subCategoryList.add(DropDownItem(element, element.name));
        });
        selectedSubCategory = subCategoryList.firstWhere((element) {
          print(element.key.name);
          print(widget.myProduct.details.subcategory);
          print(element.key.name == widget.myProduct.details.subcategory);
          return element.key.name == widget.myProduct.details.subcategory;
        });

        // List<DynamicField> formField;
        widget.myProduct.details.fileds.forEach((element) {
          labels[element.key] = element.value;
        });
      });
    }
  }

  void categoryCallback(DropDownItem item) async {
    Category.Category category = item.key;
    selectedCategory = item;
    mCategoryBloc.add(SubCategoryEvent(category));
  }

  void durationCallback(DropDownItem item) async {
    selectedDuration = item;
  }

  void subCategoryCallback(DropDownItem item) {
    selectedSubCategory = item;
    mCategoryBloc.add(ChangeSubCategory(item));
  }

  _imgFromCamera(TypeEnum typeEnum) async {
    var picker = ImagePicker();
    var image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 70);
    setState(() {
      bookingBloc.add(UploadPhotoEvent(image, typeEnum));
    });
  }

  _imgFromGallery(TypeEnum typeEnum) async {
    var picker = ImagePicker();
    var image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 70);
    setState(() {
      print("Ye do baar call ho raha hai ");
      bookingBloc.add(UploadPhotoEvent(image, typeEnum));
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

  void showSubScriptionDialog(List<Feature> data) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(
                          CupertinoIcons.clear,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    alignment: Alignment.topCenter,
                    child: Text(
                      S.of(context).startYour30dayFreeTrailNow,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: config.Colors().orangeColor),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.check_mark_circled,
                            size: 25,
                            color: config.Colors().orangeColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              S.of(context).startYour30dayFreeTrailNow,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.check_mark_circled,
                            size: 25,
                            color: config.Colors().orangeColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              S.of(context).youCanAddUpTo3Products,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: RentorRaisedButton(
                      child: Text(
                        S.of(context).startNow,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, right: 10, left: 10, bottom: 20),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: config.Colors().orangeColor,
                        thickness: 1.5,
                      )),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text(S.of(context).or,
                            style: TextStyle(
                                color: config.Colors().orangeColor,
                                fontSize: 18)),
                      ),
                      Expanded(
                          child: Divider(
                        color: config.Colors().orangeColor,
                        thickness: 1.5,
                      )),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.topCenter,
                    child: Text(
                      S.of(context).toAvailUnlimitedAccessSubscriptionNow,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: config.Colors().orangeColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: RentorRaisedButton(
                      child: Text(
                        S.of(context).subscriptionss,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showFeatureListDialog(data);
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget createDynamicTextField(String key, String value) {
    TextEditingController controller = new TextEditingController();
    controller.text = value;
    dynamicController[key] = controller;
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: AuctionField(hint: key, mController: controller));
  }

  @override
  Widget build(BuildContext context) {
    dynamicController.clear();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).createListing),
          ),
          body: BlocProvider(
              create: (BuildContext context) => CategoryListBloc(),
              child: BlocBuilder<CategoryListBloc, BaseState>(
                  bloc: mCategoryBloc,
                  builder: (BuildContext context, BaseState state) {
                    if (state is LoadingState) {
                      labels.clear();
                      dynamicController.clear();
                      return ProgressIndicatorWidget();
                    } else {
                      if (selectedSubCategory != null &&
                          selectedSubCategory.key != null) {
                        for (var item in selectedSubCategory.key.formField) {
                          labels[item.lable] = labels[item.lable];
                        }
                      }
                      return Container(
                          child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _showPicker(context, TypeEnum.IMAGE1);
                                    },
                                    child: SizedBox(
                                      width: 120,
                                      height: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            "assets/img/frame.svg",
                                            width: 120,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              S.of(context).addPhoto,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                      height: 150,
                                      width: config.App(context).appWidth(50),
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
                                                  imageUrl:
                                                      imagePickedList[index]
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
                            ),
                            Divider(),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: FormFieldDropDownWidget(
                                      hint: S.of(context).from,
                                      dropdownItems: categoryList,
                                      callback: categoryCallback,
                                      selected: selectedCategory,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: FormFieldDropDownWidget(
                                          hint: S.of(context).from,
                                          selected: selectedSubCategory,
                                          dropdownItems: subCategoryList,
                                          callback: subCategoryCallback)),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: AuctionField(
                                        hint: S.of(context).productName,
                                        mController: productName,
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: config.App(context)
                                                .appWidth(66),
                                            child: AuctionField(
                                              inputType: TextInputType.number,
                                              hint: S.of(context).priceinUsd,
                                              mController: price,
                                            ),
                                          ),
                                          SizedBox(
                                            width: config.App(context)
                                                .appWidth(28),
                                            child: FormFieldDropDownWidget(
                                              hint: S.of(context).from,
                                              selected: selectedDuration,
                                              dropdownItems: durationItems,
                                              callback: durationCallback,
                                            ),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: AuctionField(
                                        inputType:
                                            TextInputType.numberWithOptions(
                                                signed: false),
                                        hint: S
                                            .of(context)
                                            .minimumBookingAmountinUsd,
                                        mController: mini,
                                      )),
                                  InkWell(
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        alignment: AlignmentDirectional.centerStart,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(top: 10,),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: config.Colors().accentDarkColor),
                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                        ),
                                        child: Text(
                                          ' $selectedLocation',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 16,color: config.Colors().accentDarkColor,),
                                        )),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapScreen(callback:(val){
                                        setState(() {
                                          selectedLocation=val.address;
                                          latlon=val.latLng;
                                        });
                                      },)));
                                    },
                                  ),
                                  for (var order in labels.entries)
                                    createDynamicTextField(
                                        order.key, order.value),
                                  if (labels.isEmpty ||
                                      (selectedSubCategory != null &&
                                          selectedSubCategory.key != null &&
                                          selectedSubCategory
                                                  .key.formField.length ==
                                              0))
                                    RentorRaisedButton(
                                      onPressed: () {
                                        showInputDialog();
                                      },
                                      child: Text(
                                        S.of(context).addProductDetails,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: AuctionField(
                                        maxline: 5,
                                        disableContentPadding: false,
                                        hint: S.of(context).description,
                                        mController: description,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(10),
                              child: RentorRaisedButton(
                                onPressed: () => next(),
                                child: Text(
                                  S.of(context).next,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                    }
                  }))),
    );
  }

  void next() async {
    for (var item in dynamicController.entries) {
      if (item.value.text.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: S.of(context).pleaseAddItemkey(item.key));
        break;
      }
    }
    var productNameText = productName.text.trim();
    var priceText = price.text.trim();
    var minimumText = mini.text.trim();
    var descriptionText = description.text.trim();

    if (productNameText.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseAddProductName);
      return;
    } else if (priceText.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseAddPrice);
      return;
    } else if (minimumText.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseAddMinimumAmount);
      return;
    } else if (descriptionText.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseAddDescription);
      return;
    }
    var user = await Utils.getUser();
    List<home.Filed> fields = List();
    labels.forEach((key, value) {
      fields.add(
          (home.Filed(key: key, value: dynamicController[key].text.trim())));
    });
    if (imagePickedList.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseSelectImage);
      return;
    }

    var details = home.Details();
    details.fileds = fields;
    details.price = priceText;
    details.minBookingAmount = minimumText;
    details.description = descriptionText;
    details.productName = productNameText;
    details.subcategory = selectedSubCategory.value;
    details.category = selectedCategory.value;
    details.priceUnit = selectedDuration.key;

    details.images = imagePickedList.map((e) => e.imageUrl).toList().toString();
    AddProductModel model = AddProductModel();
    model.name = productNameText;

    model.categoryId = selectedCategory.key.id;
    model.subCategoryId = selectedSubCategory.key.id;
    model.userId = user.data.id;
    model.details = details;
    model.details.lat=latlon.latitude.toString();
    model.details.lng=latlon.longitude.toString();
    var body = Map();
    body['new'] = model;
    body['old'] = widget.myProduct;
    Navigator.of(context).pushNamed("/personal_detail", arguments: body);
  }

  void showInputDialog() {
    TextEditingController controller = new TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      automaticallyImplyLeading: false,
                      title: Text(S.of(context).addProductFields),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: AuctionFormField(
                          S.of(context).addFieldName,
                          mController: controller,
                        )),
                    Container(
                        width: config.App(context).appWidth(100),
                        margin: EdgeInsets.all(10),
                        child: RentorRaisedButton(
                          onPressed: () {
                            if (controller.text.trim().isEmpty) {
                              Fluttertoast.showToast(
                                  msg: S.of(context).pleaseAddFieldName);
                            } else {
                              setState(() {
                                labels[controller.text.trim()] = "";
                              });

                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            S.of(context).add,
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showFeatureListDialog(featureListData) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(
                          CupertinoIcons.clear,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.topCenter,
                    child: Text(
                      S.of(context).subscriptionPlans,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: config.Colors().orangeColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      S
                          .of(context)
                          .chooseBestSuitablePlanForYouAndAddUnlimitedProducts,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).selectPlan,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    height: config.App(context).appHeight(15),
                    width: config.App(context).appWidth(90),
                    child: ListView.builder(
                        itemCount: featureListData.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return featureCard(featureListData[index],
                              featureListData, setState);
                        }),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    child: RentorRaisedButton(
                      onPressed: () {
                        gotoPaymentMethod();
                      },
                      child: Text(
                        S.of(context).continuee,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  void gotoPaymentMethod() {
    if (selectedFeature == null) {
      Fluttertoast.showToast(msg: S.of(context).pleaseSelectAnyFeature);
      return;
    }
    var map = Map();
    map["feat"] = selectedFeature;
    map["prod"] = null;
    Navigator.of(context)
        .popAndPushNamed("/payment_method", arguments: map)
        .then((value) {
      mCategoryBloc.add(CategoryListEvent());
    });
  }

  Widget featureCard(Feature data, List<Feature> featureListData, setState) {
    return InkWell(
        onTap: () {
          setState(() {
            if (selectedFeature != null) {
              int index = featureListData.indexOf(selectedFeature);
              featureListData[index] = featureListData[index].markUnSelected;
            }

            selectedFeature = data.markSelected;
            int index = featureListData.indexOf(selectedFeature);
            featureListData[index] = featureListData[index].markSelected;
            var temp = List<Feature>();
            temp.addAll(featureListData);
            featureListData.clear();
            featureListData.addAll(temp);
          });
        },
        child: Container(
          width: config.App(context).appWidth(40),
          child: Card(
              elevation: 5,
              shape: data.isSelected
                  ? new RoundedRectangleBorder(
                      side: new BorderSide(
                          color: config.Colors().orangeColor, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0))
                  : new RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0)),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                          fontSize: 15,
                          color: data.isSelected
                              ? config.Colors().orangeColor
                              : Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        S.of(context).forr(data.period),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w200),
                      ),
                    ),
                    Text(
                      data.currencyType + " " + data.price,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),
        ));
  }
}
