import 'package:rentors/model/Response.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<Response> addReview(
    String productId, double rating, String comment) async {
  var model = await Utils.getUser();
  var map = Map();
  map['product_id'] = productId;
  map['star'] = rating.toString();
  map['comment'] = comment;
  map['user_id'] = model.data.id;
  var response = await dio.httpClient().post("Review/review", data: map);
  return Response.fromJson(response.data);
}

Future<Response> requestReview(String recieverId, String productId) async {
  var map = Map();
  map['receiver_user_id'] = recieverId;
  map['product_id'] = productId;
  var response =
      await dio.httpClient().post("review/request_review", data: map);
  return Response.fromJson(response.data);
}
