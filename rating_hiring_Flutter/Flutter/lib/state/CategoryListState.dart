import 'package:rentors/model/UserDetail.dart';
import 'package:rentors/model/category/CategoryList.dart';
import 'package:rentors/model/subscription/CheckSubscriptionModel.dart';
import 'package:rentors/state/BaseState.dart';

class CategoryListState extends BaseState {
  final CategoryList categoryList;
  final CheckSubscriptionModel checkuser;
  final UserDetail userDetail;

  CategoryListState(this.categoryList, {this.checkuser,this.userDetail});
}
