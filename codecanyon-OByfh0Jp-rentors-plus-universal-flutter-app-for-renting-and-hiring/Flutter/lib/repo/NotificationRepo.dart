import 'package:rentors/model/NotificationModel.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<NotificationModel> getNotification() async {
  UserModel model = await Utils.getUser();
  String id = model.data.id;
  var response = await dio.httpClient().get("Notification/detail/$id");
  return NotificationModel.fromJson(response.data);
}
