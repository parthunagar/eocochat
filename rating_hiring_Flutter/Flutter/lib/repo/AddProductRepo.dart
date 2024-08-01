
import 'package:rentors/model/AddProductModel.dart';
import 'package:rentors/model/Response.dart' as res;
import 'package:rentors/repo/FreshDio.dart' as dio;

Future<res.Response> addProduct(AddProductModel productModel) async {
  var response = await dio
      .httpClient()
      .post("product/create", data: productModel.toJson());
  return res.Response.fromJson(response.data);
}

Future<res.Response> updateProduct(
    AddProductModel productModel, String productId) async {
  var response = await dio
      .httpClient()
      .put("product/update/$productId", data: productModel.toJson());
  return res.Response.fromJson(response.data);
}
