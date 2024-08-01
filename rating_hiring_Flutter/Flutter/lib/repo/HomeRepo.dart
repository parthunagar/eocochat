import 'package:rentors/model/home/Home.dart';
import 'package:rentors/model/home/HomeBean.dart';
import 'package:rentors/model/home/HomeModel.dart';
import 'package:rentors/model/home/Separator.dart';
import 'package:rentors/model/home/SingleCategory.dart';
import 'package:rentors/model/home/TwoCategory.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;

Future<Home> getHomeData(String lat,String lng) async {
  var response = await dio.httpClient().get("home/index/%0A/"+lat+"/"+lng);
  var parsed = HomeModel.fromJson(response.data);
  var list = List<dynamic>();
  int size = parsed.data.category.length;
  var temp = parsed.data.category;
 /* int index = 0;
  do {
      Category one = temp[index];
      Category two;
      index++;
      if (index < size) {
        two = temp[index];
        index++;
      }
      list.add(TwoCategoryCategory(one, two));

  } while (index < size);*/
  temp.forEach((element) {
    list.add(SingleCategory(element));
  });
  return Home(parsed.data.homeSliderImage, list, parsed.data.featuredProducts,
      await parsedProduct(parsed.data.products), parsed.data.sliderImage,parsed.data.near_by_search);
}

Future<List<HomeBean>> parsedProduct(List<PurpleProduct> product) async {
  var response = List<HomeBean>();
  product.forEach((element) {
    response.add(Separator(element.category));
    element.subCategory.forEach((sub) {
      sub.subCategoryId = sub.products.first.subCategoryId;
    });
    response.addAll(element.subCategory);
  });
  return response;
}
