import 'package:rentors/model/Response.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<Response> changePassword(String newPassword) async {
  UserModel model = await Utils.getUser();
  var body = Map();
  body["user_id"] = model.data.id;
  body["new_pass"] = newPassword;
  var response = await dio.httpClient().post("home/changePassword", data: body);
  return Response.fromJson(response.data);
}
