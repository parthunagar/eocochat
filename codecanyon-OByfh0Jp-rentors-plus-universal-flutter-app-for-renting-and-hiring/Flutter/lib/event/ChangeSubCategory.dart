import 'package:rentors/event/BaseEvent.dart';
import 'package:rentors/model/DropDownItem.dart';

class ChangeSubCategory extends BaseEvent {
  final DropDownItem category;

  ChangeSubCategory(this.category);
}
