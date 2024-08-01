import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/model/AddProductModel.dart';
import 'package:rentors/model/MyProductModel.dart';

class AddProductEvent extends BaseEvent {
  final AddProductModel body;
  final MyProduct oldProduct;

  AddProductEvent(this.body, this.oldProduct);
}
