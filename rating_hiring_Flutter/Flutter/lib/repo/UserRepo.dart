import 'package:rentors/model/Response.dart';
import 'package:rentors/model/UserDetail.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<UserDetail> getUserDetail() async {
  UserModel model = await Utils.getUser();
  String id = model.data.id;
  var response = await dio.httpClient().get("profile/detail/$id");
  return UserDetail.fromJson(response.data);
}

Future<Response> updateUserDetails(body) async {
  UserModel model = await Utils.getUser();
  String id = model.data.id;
  var response = await dio.httpClient().put("profile/update/$id", data: body);
  return Response.fromJson(response.data);
}
