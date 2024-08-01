import 'package:rentors/model/MyProductModel.dart';
import 'package:rentors/model/Response.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<MyProductModel> getMyProduct() async {
  var user = await Utils.getUser();
  var response =
      await dio.httpClient().get("Product/myAddedProduct/${user.data.id}");
  var parsed = MyProductModel.fromJson(response.data);
  return parsed;
}

Future<Response> deleteProduct(productId) async {
  var response = await dio.httpClient().get("product/deleteProduct/$productId");
  var parsed = Response.fromJson(response.data);
  return parsed;
}

Future<Response> changeStatus(String productId, String status) async {
  var user = await Utils.getUser();
  var body = Map();
  body["product_id"] = productId;
  body["user_id"] = user.data.id;
  body["status"] = status;
  var response =
      await dio.httpClient().post("product/changeProductStatus", data: body);
  var parsed = Response.fromJson(response.data);
  return parsed;
}
