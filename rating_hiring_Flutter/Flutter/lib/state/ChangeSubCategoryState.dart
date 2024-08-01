import 'package:rentors/model/DropDownItem.dart';
import 'package:rentors/state/BaseState.dart';

class ChangeSubCategoryState extends BaseState {
  final DropDownItem category;

  ChangeSubCategoryState(this.category);
}
