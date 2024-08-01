import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rentors/bloc/CategoryListBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/CategoryListEvent.dart';
import 'package:rentors/event/ChangeSubCategory.dart';
import 'package:rentors/event/CityEvent.dart';
import 'package:rentors/event/SearchEvent.dart';
import 'package:rentors/event/SubCategoryEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/DropDownItem.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CategoryListState.dart';
import 'package:rentors/state/ChangeSubCategoryState.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SubCategoryListState.dart';
import 'package:rentors/widget/FormFieldDropDownWidget.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';
import 'package:rentors/widget/ProgressIndicatorWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:rentors/model/category/CategoryList.dart' as Category;

class FilterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilterScreenState();
  }
}

class FilterScreenState extends RentorState<FilterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showProgress = false;
  List<DropDownItem> subCategoryList = [];
  List<DropDownItem> categoryList = [];
  List<DropDownItem> cityList = [];
  CategoryListBloc mCategoryBloc = CategoryListBloc();
  DropDownItem selectedCategory;
  DropDownItem selectedSubCategory;
  DropDownItem selectedCity;
  String queryString = '';
  double _priceValue = 10;
  double _distanceValue = 5;
  Position currentLocation;
  int selected = 1;

  @override
  void initState() {
    super.initState();
    showProgress = false;
    mCategoryBloc.add(CategoryListEvent());
    mCategoryBloc.add(CityEvent());
    mCategoryBloc.listen((state) {
      print("Category bloc");
      if (state is CategoryListState) {
        categoryList.clear();
        categoryList.add(DropDownItem(null, 'All Category'));
        state.categoryList.data.forEach((element) {
          categoryList.add(DropDownItem(element, element.name));
        });
        var category = state.categoryList.data.first;
        subCategoryList.add(DropDownItem(null, 'All Sub Category'));
        category.subCategory.forEach((element) {
          subCategoryList.add(DropDownItem(element, element.name));
        });
        setState(() {
          selectedCategory = categoryList.first;
          selectedSubCategory = subCategoryList.first;
        });
      } else if (state is CityState) {
        cityList.clear();
        state.home.data.forEach((element) {
          cityList.add(DropDownItem(element, element.cityName));
        });
        setState(() {
          selectedCity = cityList.first;
        });
      } else if (state is ChangeSubCategoryState) {
        setState(() {
          selectedSubCategory = state.category;
        });
      }
    });
  }

  void categoryCallback(DropDownItem item) async {
    Category.Category category = item.key;
    // var category = item.key;
    List<DropDownItem> subCategoryListtep = [];

    category.subCategory.forEach((element) {
      subCategoryListtep.add(DropDownItem(element, element.name));
    });
    if (subCategoryListtep.length == 0) {
      subCategoryListtep.add(DropDownItem(null, "No subcategory available"));
    }
    setState(() {
      selectedCategory = item;
      subCategoryList = subCategoryListtep;
      selectedSubCategory = subCategoryList.first;
    });
    mCategoryBloc.add(SubCategoryEvent(category));
  }

  void subCategoryCallback(DropDownItem item) {
    selectedSubCategory = item;
    mCategoryBloc.add(ChangeSubCategory(item));
  }

  void brandCallback(DropDownItem item) {
    selectedCity = item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Filter",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        body: BlocProvider(
          create: (context) => CategoryListBloc(),
          child: BlocBuilder<CategoryListBloc, BaseState>(
            bloc: mCategoryBloc,
            builder: (context, state) {
              if (state is LoadingState) {
                return ProgressIndicatorWidget();
              }
              return mainFilter();
            },
          ),
        ));
  }

  @override
  void update() {}

  Widget mainFilter() {
    return Container(
      color: config.Colors().white,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20),
            child: FormFieldDropDownWidget(
              dropdownItems: categoryList,
              callback: categoryCallback,
              selected: selectedCategory,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.only(top: 5, left: 20, right: 20),
              child: FormFieldDropDownWidget(
                  hint: S.of(context).from,
                  selected: selectedSubCategory,
                  dropdownItems: subCategoryList,
                  callback: subCategoryCallback)),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: config.Colors().accentDarkColor,
            height: 2,
          ),
          Row(
            children: [
              Radio(
                  value: selected,
                  groupValue: 1,
                  onChanged: (v) {
                    setState(() {
                      selected = 1;
                    });
                  }),
              Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 20, bottom: 10),
                child: Text(
                  'Select City',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          Visibility(
            visible: selected==1,
            child: Container(
              margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
              child: FormFieldDropDownWidget(
                  hint: S.of(context).from,
                  selected: selectedCity,
                  dropdownItems: cityList,
                  callback: brandCallback)),),
          Row(
            children: [
              Radio(
                  value: selected,
                  groupValue: 2,
                  onChanged: (v) {
                    setState(() {
                      selected = 2;
                    });
                  }),
              Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 20, bottom: 10),
                child: Text(
                  'Distance',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          Visibility(
              visible: selected == 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Distance Start 0 KM TO ${_distanceValue.round().toString()} KM',
                      style: TextStyle(color: config.Colors().accentDarkColor),
                    ),
                  ),
                  RangeSlider(
                    values: RangeValues(0, _distanceValue),
                    min: 0,
                    max: 100,
                    divisions: 5,
                    inactiveColor: config.Colors().accentDarkColor,
                    activeColor: config.Colors().mainDarkColor,
                    labels: RangeLabels("0", '$_distanceValue'),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _distanceValue = values.end;
                      });
                    },
                  )
                ],
              )),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Price'),
            subtitle: Text(
              'Price Start 0 \$ TO ${_priceValue.round().toString()} \$',
              style: TextStyle(color: config.Colors().accentDarkColor),
            ),
          ),
          RangeSlider(
            values: RangeValues(0, _priceValue),
            min: 0,
            max: 10000,
            divisions: 100,
            inactiveColor: config.Colors().accentDarkColor,
            activeColor: config.Colors().mainDarkColor,
            labels: RangeLabels("0", '$_priceValue'),
            onChanged: (RangeValues values) {
              setState(() {
                _priceValue = values.end;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: RentorRaisedButton(
              child: Text(
                'Filter',
                style: TextStyle(color: config.Colors().white),
              ),
              onPressed: () {
                var arg=SearchEvent(queryString,selectedCategory.value,selectedSubCategory.value,selectedCity.value,"0",_priceValue.round().toString(),"0",_distanceValue.round().toString(),currentLocation);
               Navigator.pushNamed(context, '/search',arguments: arg);
              },
            ),
          )

        ],
      ),
    );
  }
}
