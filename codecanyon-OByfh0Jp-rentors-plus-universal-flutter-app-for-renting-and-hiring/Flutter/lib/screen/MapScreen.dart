import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_place/google_place.dart';
import 'package:rentors/config/app_config.dart' as config;
import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';
typedef Modelcallback = ModelAddress Function(ModelAddress);
class MapScreen extends StatefulWidget {
  Modelcallback callback;
  @override
  State<MapScreen> createState() => MapSampleState();
  MapScreen({this.callback});
}
class ModelAddress{
  String _address;
  LatLng _latLng;

  LatLng get latLng => _latLng;
  String get address => _address;

  set latLng(LatLng value) {
    _latLng = value;
  }
  set address(String value) {
    _address = value;
  }
}

class MapSampleState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  bool showProgress = false;
  Address addresses;
  final searchOnChange = new BehaviorSubject<String>();
  AutocompleteResponse risult;
  LatLng latLng;
  @override
  void initState() {
    super.initState();
    var googlePlace = GooglePlace("");
    searchOnChange.debounceTime(Duration(milliseconds: 500))
        .listen((queryString) async {
       risult = await googlePlace.autocomplete.get(queryString);
       setState(() {
       });
    });
    _determinePosition().then((value) async{
      final coordinates = new Coordinates(value.latitude, value.longitude);
      var addre = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      addresses = addre.first;
      latLng=new LatLng(value.latitude, value.longitude);
       setState(() {
       });
    });
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: [
          risult!=null?
          Expanded(child: ListView.builder(
            primary: false,
            itemCount: risult.predictions.length,
            itemBuilder: (context, index) {
              return Container(
                  color: config.Colors().white,
                  child: ListTile(
                    leading:Icon(Icons.location_history,color: config.Colors().mainDarkColor,),
                    title: Text(risult.predictions[index].description,style: TextStyle(
                        color: config.Colors().secondColor
                    )),
                    onTap: (){
                      locationAddress(risult.predictions[index].description);
                    },
                  )
              );
            },)):Container(
            width: MediaQuery.of(context).size.width,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              border: Border.all(color: config.Colors().mainDarkColor),
              color: config.Colors().accentDarkColor
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Text(addresses==null?'No Result Found':addresses.addressLine,style: TextStyle(
              color: config.Colors().white
            ),),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: config.Colors().mainDarkColor,
              ),
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.all(10),
              child: Text('Select Current Location',style: TextStyle(
                  fontSize: 18,
                color: config.Colors().white
              ),),
            ),
            onTap: (){
              if(latLng!=null) {
                if(widget.callback!=null){
                  ModelAddress event=new ModelAddress();
                  event.latLng=latLng;
                  event.address=addresses.addressLine;
                  widget.callback(event);
                  Navigator.pop(context);
                }else{
                  Navigator.of(context).pushNamed('/nearby_page', arguments:latLng);
                }
              }else{

              }
            },
          ),
        ],
      ),

      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
              border: Border.all(color: config.Colors().mainDarkColor),
              borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(child: TextField(
                  onChanged: (text) {
                    searchOnChange.add(text);
                  },
                  autofocus: true,
                  style: TextStyle(color: config.Colors().white, fontSize: 16),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search address',
                      hintStyle: TextStyle(color: config.Colors().white))),flex: 1,)
            ],
          ),
        ),
      ),
    );
  }

  locationAddress(String s) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(s);
    var first = addresses.first;
    double latitude=first.coordinates.latitude;
    double longitude=first.coordinates.longitude;
    latLng=new LatLng(latitude, longitude);
    if(widget.callback!=null){
      ModelAddress event=new ModelAddress();
      event.latLng=latLng;
      event.address=first.addressLine;
      widget.callback(event);
      Navigator.pop(context);
    }else{
      Navigator.of(context).pushNamed('/nearby_page', arguments:latLng);
    }
  }

}