import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentors/model/SearchModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;

Future<SearchModel> searchResult(String query,{String category,String sub_category,String city,String price_start,String price_end,String distance_start,String distance_end,Position currentLocation}) async {
  var map = Map();
  map["value"] = query;
  map["category"]=category;
  map["sub_category"]=sub_category;
  map["city"]=city;
  map["price_start"]=price_start;
  map["price_end"]=price_end;
  map["distance_start"]=distance_start;
  map["distance_end"]=distance_end;
  if(currentLocation!=null) {
    map["lat"] = currentLocation.latitude;
    map["lng"] = currentLocation.longitude;
  }
  print("Map==> $map");
  var response = await dio.httpClient().post("product/search", data: map);
  print("response $response");
  return SearchModel.fromJson(response.data);
}
Future<SearchModel> nearBySearchResult(LatLng query) async {
  var map = Map();
  map["lat"] = '${query.latitude}';
  map["lng"] = '${query.longitude}';
  var response = await dio.httpClient().post("product/nearbysearch", data: map);
  return SearchModel.fromJson(response.data);
}