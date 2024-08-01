import 'package:geolocator/geolocator.dart';
import 'package:rentors/event/BaseEvent.dart';

class SearchEvent extends BaseEvent {
  final String search;
  final String category, sub_category, city, price_start, price_end, distance_start, distance_end;
  Position location;
  SearchEvent(this.search,this.category, this.sub_category, this.city, this.price_start, this.price_end, this.distance_start, this.distance_end,this.location);
}
