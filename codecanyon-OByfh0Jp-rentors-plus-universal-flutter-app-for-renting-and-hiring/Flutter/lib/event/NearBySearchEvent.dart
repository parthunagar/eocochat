import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentors/event/BaseEvent.dart';

class NearBySearchEvent extends BaseEvent {
  final LatLng latLng;

  NearBySearchEvent(this.latLng);
}
