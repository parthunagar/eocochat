import 'package:mobx/mobx.dart';
import 'package:qr_menu/models/category_model.dart';

part 'menu_store.g.dart';

class MenuStore = MenuStoreBase with _$MenuStore;

abstract class MenuStoreBase with Store {
  @observable
  CategoryModel? selectedCategoryData;

  @action
  void setSelectedCategoryData(CategoryModel? image) => selectedCategoryData = image;
}
