import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/model/category/CategoryList.dart';

class SubCategoryEvent extends BaseEvent {
  final Category category;

  SubCategoryEvent(this.category);
}
