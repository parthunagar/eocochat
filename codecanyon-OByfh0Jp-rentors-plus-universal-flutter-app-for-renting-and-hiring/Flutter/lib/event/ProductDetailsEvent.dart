import 'package:rentors/event/BaseEvent.dart';

class ProductDetailsEvent extends BaseEvent {
  final String id;

  ProductDetailsEvent(this.id);
}
