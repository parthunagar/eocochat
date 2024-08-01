import 'dart:io';

import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/utils/model_keys.dart';

import 'base_service.dart';

class CategoryService extends BaseService<CategoryModel> {
  CategoryService({String? restaurantId}) {
    ref = fireStore.collection(Collections.restaurants).doc(restaurantId).collection(Collections.categories).withConverter<CategoryModel>(
          fromFirestore: (snapshot, options) => CategoryModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Future<void> removeCustomDocument(String id, String restaurantId) async {
    await ref!.doc(id).delete();
    storage.ref().child('$restaurantId/category/$id').delete();
  }

  Stream<List<CategoryModel>> getCategoryStreamData() {
    return ref!.snapshots().map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<List<CategoryModel>> getCategoryFutureData() {
    return ref!.get().then((event) => event.docs.map((e) => e.data()).toList());
  }

  static Stream<int> getTotalCategories({String? restaurantId}) {
    return fireStore.collection(Collections.restaurants).doc(restaurantId).collection(Collections.categories).snapshots().map((value) => value.docs.length);
  }

  Future<String> addCategoryInfo(Map<String, dynamic> data, String restId, {File? profileImage}) async {
    var doc = await ref!.add(CategoryModel.fromJson(data));
    ref!.doc(doc.id).update({CommonKeys.id: doc.id});

    if (profileImage != null) {
      ref!.doc(doc.id).update({Categories.image: await BaseService.getUploadedImageURL(profileImage, "$restId/${doc.id}")});
    }
    return doc.id;
  }

  Future<void> updateCategoryInfo(Map<String, dynamic> data, String id, String restId, {File? profileImage}) async {
    await ref!.doc(id).update(data);
    if (profileImage != null) {
      ref!.doc(id).update({Categories.image: await BaseService.getUploadedImageURL(profileImage, '$restId/$id')});
    }
    return;
  }

  Future<CategoryModel> getCategorySingleData({String? data}) {
    return ref!.where(CommonKeys.id, isEqualTo: data).get().then((value) {
      return value.docs.first.data();
    });
  }

  Stream<CategoryModel> getSingleStreamData({String? uId}) {
    return ref!.where(CommonKeys.id, isEqualTo: uId).snapshots().map((value) => value.docs.first.data());
  }
}
