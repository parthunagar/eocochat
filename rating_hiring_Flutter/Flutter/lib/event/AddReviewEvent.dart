import 'package:rentors/event/BaseEvent.dart';

class AddReviewEvent extends BaseEvent {
  final String productId, comment;
  final double rating;

  AddReviewEvent(this.productId, this.rating, this.comment);
}
