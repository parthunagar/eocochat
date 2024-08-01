import 'package:rentors/model/category/ConsolidateCategoryDetail.dart';
import 'package:rentors/state/BaseState.dart';

class CategoryDetailState extends BaseState {
  final ConsolidateCategoryDetail categoryList;

  CategoryDetailState(this.categoryList);
}
