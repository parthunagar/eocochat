import 'package:rentors/model/CityModel.dart';
import 'package:rentors/model/UserDetail.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/model/category/CategoryDetailModel.dart';
import 'package:rentors/model/category/CategoryList.dart';
import 'package:rentors/model/category/ConsolidateCategoryDetail.dart';
import 'package:rentors/model/category/SubCategoryDetailModel.dart'
    as subCategory;
import 'package:rentors/model/home/HomeBean.dart';
import 'package:rentors/model/home/Separator.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<CategoryList> getCategoryList() async {
  var response = await dio.httpClient().get("category/");
  return CategoryList.fromJson(response.data);
}

Future getSubCategory() async {
  return Future.delayed(Duration(milliseconds: 50));
}

Future<ConsolidateCategoryDetail> getCategoryDetails(id) async {
  var response =
      await dio.httpClient().get("category/getSubCategoryByCategoryv2/" + id);

  var res = CategoryDetailModel.fromJson(response.data);
  return ConsolidateCategoryDetail(res.data.subCategory,
      await parsedProduct(res.data.products), res.data.sliderImage);
}

Future<List<HomeBean>> parsedProduct(List<Product> product) async {
  var response = List<HomeBean>();
  product.forEach((element) {
    response.add(Separator(element.subCategoryName));
    response.add(element);
  });
  return response;
}

Future<subCategory.SubCategoryDetailModel> getSubCategoryDetail(
    String id, int page) async {
  var response = await dio.httpClient().get(
      "Product/getProductBySubCategory/" + id,
      queryParameters: {"page": page});
  var res = subCategory.SubCategoryDetailModel.fromJson(response.data);
  return res;
}
Future<UserDetail> getUserDetail() async {
  UserModel model = await Utils.getUser();
  String id = model.data.id;
  var response = await dio.httpClient().get("profile/detail/$id");
  print('profile=====> $response');
  return UserDetail.fromJson(response.data);
}

Future<CityModel> getCity() async {
  var response = await dio.httpClient().get("home/getCity");
  return CityModel.fromJson(response.data);
}