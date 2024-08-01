import 'package:rentors/model/category/CategoryDetailModel.dart';
import 'package:rentors/state/BaseState.dart';

class SubCategoryListState extends BaseState {
  final List<SubCategory> categoryList;

  SubCategoryListState(this.categoryList);
}
