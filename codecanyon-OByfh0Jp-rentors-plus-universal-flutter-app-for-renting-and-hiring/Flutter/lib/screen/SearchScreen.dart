import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/CategoryListBloc.dart';
import 'package:rentors/bloc/SearchBloc.dart';
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
import 'package:rentors/model/SearchModel.dart';
import 'package:rentors/model/category/CategoryList.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/screen/cateogry/CategoryScreenWidget.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/CategoryListState.dart';
import 'package:rentors/state/ChangeSubCategoryState.dart';
import 'package:rentors/state/CityState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SearchState.dart';
import 'package:rentors/state/SubCategoryListState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/FeatureWidget.dart';
import 'package:rentors/widget/FormFieldDropDownWidget.dart';
import 'package:rentors/widget/LikeWidget.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';
import 'package:rentors/widget/RentorRaisedButton.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rentors/model/category/CategoryList.dart' as Category;

class SearchScreen extends StatefulWidget {
  SearchEvent event;
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
  SearchScreen(this.event);
}

class SearchScreenState extends RentorState<SearchScreen> {
  SearchBloc mBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<FeaturedProductElement> searchItem = List();
  bool showProgress = false;
  final searchOnChange = new BehaviorSubject<String>();
  String queryString='';
  Position currentLocation;
  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) => {
      currentLocation=value,
    });
    mBloc = SearchBloc();
    mBloc.add(widget.event);
    searchOnChange
        .debounceTime(Duration(milliseconds: 500))
        .listen((query) {
      queryString=query;

      setState(() {
        showProgress = true;
      });
    });
    showProgress = false;
    mBloc.listen((state) {
      if (state is SearchState || state is ErrorState) {
        setState(() {
          showProgress = false;
        });
      }
      else if (state is LoadingState) {
        setState(() {
          showProgress = true;
        });
      }
    });
  }
  void openDetails(BuildContext context, FeaturedProductElement products) async {
    var map = Map();
    map["id"] = products.id;
    map["name"] = products.name;
    Navigator.of(context).pushNamed("/product_details", arguments: map);
  }

  Widget cardView(FeaturedProductElement product) {
    return InkWell(
        onTap: () {
          openDetails(context, product);
        },
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: config.Colors().mainDarkColor)
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    color: config.Colors().white,
                    child:Stack(children: [
                      Center(
                        child: OptimizedCacheImage(
                            placeholder: (context, url) {
                              return PlaceHolderWidget();
                            },
                            fit: BoxFit.fitWidth,
                            height: 130,
                            imageUrl: product.details.images),
                      ),
                      FeatureWidget(
                        product.isFeatured,
                        radius: 0,
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: config.Colors().secondColor,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            " ${product.details.description}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                color: config.Colors().secondColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              S.of(context).rate(
                                  product.details.price +
                                      "/" +
                                      priceUnitValues.reverse[product
                                          .details
                                          .priceUnit]),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: config.Colors().secondColor,
                                  fontWeight: FontWeight.w400),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              S.of(context).minimumBookingAmount(
                                  product.details
                                      .minBookingAmount),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: config.Colors().secondColor,
                                  fontWeight: FontWeight.w400),
                            )),
                        Container(
                          alignment: AlignmentDirectional.topEnd,
                          margin: EdgeInsets.only(left: 5),
                          child: IconButton(
                            onPressed: () {
                              openDetails(context,product);
                            },
                            icon: Icon(Icons.arrow_forward_ios_outlined,color: config.Colors().mainDarkColor,),
                          ),
                        ),
                      ],
                    ),)
                ],
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: InheritedStateContainer(
          state: this,
          child: BlocProvider(
              create: (BuildContext context) => mBloc,
              child: BlocBuilder<SearchBloc, BaseState>(
                  bloc: mBloc,
                  builder: (BuildContext context, BaseState state) {
                    if (state is SearchState) {
                      searchItem.clear();
                      searchItem.addAll(state.model.data);
                    } else if (state is ErrorState) {
                      searchItem.clear();
                    }
                    return Hero(
                      tag: "home_screen_search_key",
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return cardView(searchItem[index]);
                        },
                        itemCount: searchItem.length,
                      ),
                    );
                  }))),
      appBar: AppBar(
        brightness: Brightness.dark,
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 1.0),
            child: showProgress ? LinearProgressIndicator(color: config.Colors().secondColor,) : Container()),
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: config.Colors().mainDarkColor),
            borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(child: TextField(
                  onChanged: (text) {
                    searchOnChange.add(text);
                  },
                  autofocus: false,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: S
                          .of(context)
                          .search,
                      hintStyle: TextStyle(color: Colors.white))),flex: 1,),
            ],
          ),
        ),

      ),
    );
  }
  @override
  void update() {

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
