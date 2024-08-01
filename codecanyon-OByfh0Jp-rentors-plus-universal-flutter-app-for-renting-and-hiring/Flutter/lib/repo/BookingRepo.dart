import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentors/model/CityModel.dart';
import 'package:rentors/model/Response.dart' as res;
import 'package:rentors/model/UploadPicsModel.dart';
import 'package:rentors/model/UserModel.dart';
import 'package:rentors/model/booking/MyBooking.dart';
import 'package:rentors/model/booking/MyProductBookingModel.dart';
import 'package:rentors/repo/FreshDio.dart' as dio;
import 'package:rentors/util/Utils.dart';

Future<MyBooking> getBookingRepo() async {
  UserModel model = await Utils.getUser();
  var response = await dio
      .httpClient()
      .get("product/requestedBookingForProduct/" + model.data.id);
  return MyBooking.fromJson(response.data);
}

Future<CityModel> getCity() async {
  var response = await dio.httpClient().get("home/getCity");
  return CityModel.fromJson(response.data);
}

Future<UploadPicsModel> uploadPhoto(PickedFile file) async {
  var formdata = FormData.fromMap({
    "avatar": await MultipartFile.fromFile(file.path,
        filename: DateTime.now().toString()),
  });
  var response = await dio.httpClient().post("upload", data: formdata);
  return UploadPicsModel.fromJson(response.data);
}

Future<res.Response> addBookingProduct(Map body) async {
  body.remove("details");
  UserModel model = await Utils.getUser();
  body['user_id'] = model.data.id;
  var response =
      await dio.httpClient().post("product/productBooking", data: body);
  return res.Response.fromJson(response.data);
}

Future<MyProductBookingModel> getMyProductBooking() async {
  UserModel model = await Utils.getUser();
  var response = await dio
      .httpClient()
      .get("product/getmyproductbooking/" + model.data.id);
  return MyProductBookingModel.fromJson(response.data);
}

Future<MyBooking> getBookingRequestList(String id) async {
  var response =
      await dio.httpClient().get("product/bookingRequestedUsers/" + id);
  return MyBooking.fromJson(response.data);
}

Future<res.Response> changeBookingStatus(
    String productId, String buyerId, String status) async {
  var body = Map();
  // @SerializedName("product_id")
  // public String product_id;
  // @SerializedName("buyer_id")
  // public String buyer_id;
  // @SerializedName("status")
  // public String status;

  body["product_id"] = productId;
  body["buyer_id"] = buyerId;
  body["status"] = status;
  var response =
      await dio.httpClient().post("product/confirmRejectBooking", data: body);
  return res.Response.fromJson(response.data);
}
