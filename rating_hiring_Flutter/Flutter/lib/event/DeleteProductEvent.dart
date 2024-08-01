import 'package:rentors/event/BaseEvent.dart';

class DeleteProductEvent extends BaseEvent {
  final String productId;
  DeleteProductEvent(this.productId);
}
