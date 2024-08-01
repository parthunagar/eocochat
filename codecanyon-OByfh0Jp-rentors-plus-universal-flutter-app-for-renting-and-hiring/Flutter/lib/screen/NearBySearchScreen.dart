import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rentors/bloc/SearchBloc.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rentors/core/InheritedStateContainer.dart';
import 'package:rentors/core/RentorState.dart';
import 'package:rentors/event/NearBySearchEvent.dart';
import 'package:rentors/event/SearchEvent.dart';
import 'package:rentors/generated/l10n.dart';
import 'package:rentors/model/SearchModel.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/state/BaseState.dart';
import 'package:rentors/state/ErrorState.dart';
import 'package:rentors/state/OtpState.dart';
import 'package:rentors/state/SearchState.dart';
import 'package:rentors/util/Utils.dart';
import 'package:rentors/widget/FeatureWidget.dart';
import 'package:rentors/widget/LikeWidget.dart';
import 'package:rentors/widget/PlaceHolderWidget.dart';
import 'package:rxdart/rxdart.dart';

class NearBySearchScreen extends StatefulWidget {
  LatLng latlng;

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }

  NearBySearchScreen(this.latlng);
}

class SearchScreenState extends State<NearBySearchScreen> {
  SearchBloc mBloc;

  List<FeaturedProductElement> searchItem = List();

  bool showProgress = false;
  final searchOnChange = new BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    showProgress = false;
    mBloc = SearchBloc();
    mBloc.add(NearBySearchEvent(widget.latlng));
    mBloc.listen((state) {
      if (state is SearchState) {
        setState(() {
          searchItem = state.model.data;
          showProgress = false;
        });
      } else if (state is LoadingState) {
        setState(() {
          showProgress = true;
        });
      } else if (state is ErrorState) {
        setState(() {
          showProgress = false;
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
          decoration:
              BoxDecoration(border: Border.all(color: config.Colors().mainDarkColor)),
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
                    child: Stack(children: [
                      Center(
                        child: Image.network(product.details.images,
                            fit: BoxFit.fitWidth, height: 130),
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
                            SizedBox(
                              width: 5,
                            ),
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
                            product.details.description,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                color: config.Colors().secondColor,
                                fontWeight: FontWeight.w400,
                            ),
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
                                  product.details.minBookingAmount),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: config.Colors().secondColor,
                                  fontWeight: FontWeight.w400),
                            )),
                        Stack(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on,color: config.Colors().mainDarkColor,size: 15,),
                                    Text( "${product.distance} KM",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: config.Colors().secondColor,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )),
                            Container(
                              alignment: AlignmentDirectional.topEnd,
                              margin: EdgeInsets.only(left: 5),
                              child: IconButton(
                                onPressed: () {
                                  openDetails(context, product);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: config.Colors().secondColor,
                                ),
                              ),
                            ),
                          ],
                        )


                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: searchItem.length > 0
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return cardView(searchItem[index]);
                  },
                  itemCount: searchItem.length,
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'No Data found',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        ),
      ),
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 1.0),
            child: showProgress ? LinearProgressIndicator(color: config.Colors().secondColor,) : Container()),
        title: Text('Near By Search Result'),
      ),
    );
  }

  @override
  void update() {}
}
