import 'package:rentors/model/Response.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<Response> complaint(String title, String complaint) async {
  UserModel model = await Utils.getUser();
  var body = Map();
  body["user_id"] = model.data.id;
  body["title"] = title;
  body["Complaint"] = complaint;
  var response = await dio.httpClient().post("home/user_complaint", data: body);
  return Response.fromJson(response.data);
}
