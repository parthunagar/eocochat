import 'dart:io';

import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:qr_menu/utils/model_keys.dart';

import 'base_service.dart';

class RestaurantOwnerService extends BaseService<RestaurantModel> {
  RestaurantOwnerService() {
    ref = fireStore.collection(Collections.restaurants).withConverter<RestaurantModel>(
          fromFirestore: (snapshot, options) => RestaurantModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Stream<List<RestaurantModel>> getRestaurantData() {
    return ref!.where(Restaurants.userId, isEqualTo: getStringAsync(SharePreferencesKey.USER_ID)).snapshots().map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<RestaurantModel> getRestaurantFutureData(String? id) async {
    return ref!.limit(1).where(CommonKeys.id, isEqualTo: id).get().then((value) => value.docs.first.data());
  }

  Future<String> addResturantInfo(Map<String, dynamic> data, {File? profileImage, File? logoImage}) async {
    var doc = await ref!.add(RestaurantModel.fromJson(data));
    ref!.doc(doc.id).update({CommonKeys.id: doc.id});

    if (profileImage != null) {
      ref!.doc(doc.id).update({Restaurants.image: await BaseService.getUploadedImageURL(profileImage, doc.id)});
    }
    if (logoImage != null) {
      ref!.doc(doc.id).update({Restaurants.logoImage: await BaseService.getUploadedImageURL(logoImage, "Logo${doc.id}")});
    }
    return doc.id;
  }

  Future<void> updateResturantInfo(Map<String, dynamic> data, String id, {File? profileImage, File? logoImage}) async {
    await ref!.doc(id).update(data);
    if (profileImage != null) {
      ref!.doc(id).update({Restaurants.image: await BaseService.getUploadedImageURL(profileImage, id)});
    }

    if (logoImage != null) {
      ref!.doc(id).update({Restaurants.logoImage: await BaseService.getUploadedImageURL(logoImage, "Logo$id")});
    }
    return;
  }

  Stream<int> getLength() {
    return ref!.where(Restaurants.userId, isEqualTo: getStringAsync(SharePreferencesKey.USER_ID)).snapshots().map((event) => event.docs.length);
  }
}
