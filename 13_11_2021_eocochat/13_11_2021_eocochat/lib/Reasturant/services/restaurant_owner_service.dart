import 'dart:io';

import 'package:fiberchat/Configs/Dbkeys.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/models/restaurant_model.dart';
import 'package:fiberchat/Reasturant/utils/constants.dart';
import 'package:fiberchat/Reasturant/utils/model_keys.dart';

import 'base_service.dart';

class RestaurantOwnerService extends BaseService<RestaurantModel> {
  RestaurantOwnerService() {
    ref = fireStore.collection(Collections.restaurants).withConverter<RestaurantModel>(
          fromFirestore: (snapshot, options) => RestaurantModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson());
  }

  Stream<List<RestaurantModel>> getRestaurantData(String userId) {
    // return ref!.where(Restaurants.userId, isEqualTo: getStringAsync(SharePreferencesKey.USER_ID)).snapshots().map((event) => event.docs.map((e) => e.data()).toList());
    return ref!.where(Restaurants.userId, isEqualTo: userId).snapshots().map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<RestaurantModel> getRestaurantFutureData(String? id) async {
    return ref!.limit(1).where(CommonKeys.id, isEqualTo: id).get().then((value) => value.docs.first.data());
  }

  Future<String> addResturantInfo(Map<String, dynamic> data, {File? profileImage, File? logoImage}) async {
    print('addResturantInfo => data : $data');
    print('addResturantInfo => profileImage : $profileImage');
    print('addResturantInfo => logoImage : $logoImage');
    var doc = await ref!.add(RestaurantModel.fromJson(data));
    print('addResturantInfo => doc : $doc');
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
    print('updateResturantInfo => data : $data');
    print('updateResturantInfo => profileImage : $profileImage');
    print('updateResturantInfo => logoImage : $logoImage');
    await ref!.doc(id).update(data);
    if (profileImage != null) {
      ref!.doc(id).update({Restaurants.image: await BaseService.getUploadedImageURL(profileImage, id)});
    }

    if (logoImage != null) {
      ref!.doc(id).update({Restaurants.logoImage: await BaseService.getUploadedImageURL(logoImage, "Logo$id")});
    }
    return;
  }

  Stream<int> getLength(String userId) {
    // return ref!.where(Restaurants.userId, isEqualTo: getStringAsync(SharePreferencesKey.USER_ID)).snapshots().map((event) => event.docs.length);
    return ref!.where(Restaurants.userId, isEqualTo: userId).snapshots().map((event) => event.docs.length);
  }
}
