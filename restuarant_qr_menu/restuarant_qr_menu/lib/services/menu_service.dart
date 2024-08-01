import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/menu_model.dart';
import 'package:qr_menu/utils/model_keys.dart';

import 'base_service.dart';

class MenuService extends BaseService<MenuModel> {
  MenuService({String? restaurantId}) {
    ref = fireStore.collection(Collections.restaurants).doc(restaurantId).collection(Collections.menus).withConverter<MenuModel>(
      fromFirestore: (snapshot, options) => MenuModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  Future<void> removeCustomDocument(String id, String restaurantId) async {
    await ref!.doc(id).delete();
    storage.ref().child('$restaurantId/menu/$id').delete();
  }

  Stream<List<MenuModel>> getMenuData() {
    return ref!.snapshots().map((em) => em.docs.map((e) => e.data()).toList());
  }

  Stream<List<MenuModel>> getAllDataCategoryWise({String? categoryId}) {
    if (categoryId == null) {
      return ref!.snapshots().map((em) => em.docs.map((e) => e.data()).toList());
    } else {
      return ref!.where(Menus.categoryId, isEqualTo: categoryId).snapshots().map((em) => em.docs.map((e) => e.data()).toList());
    }
  }

  Future<int> checkChildItemExist(String id, String restaurantId) async {
    return await ref!.where(Menus.categoryId, isEqualTo: id).get().then((value) => value.docs.length);
    // return fireStore.collection(Collections.restaurants).doc(restaurantId).collection(Collections.menus).where(Menus.categoryId, isEqualTo: restaurantId).snapshots().map((event) => event.docs.length);
  }

  Future checkToDelete(String id, String restaurantId) async {
    return await ref!.where(Menus.categoryId, isEqualTo: id).get().then((value) {

      var batch = fireStore.batch();
      value.docs.forEach((element) {
        batch.delete(element.reference);
      });

      return batch.commit();

    } );
    // return fireStore.collection(Collections.restaurants).doc(restaurantId).collection(Collections.menus).where(Menus.categoryId, isEqualTo: restaurantId).snapshots().map((event) => event.docs.length);
  }

  // Future<bool> deleteMenuItemCategory(String id, String restaurantId) async {
  //   return await ref!.where(Menus.categoryId, isEqualTo: id).get().then((value) {
  //     Future.forEach(value.docs, (element) {
  //       categoryService.removeCustomDocument(id, restaurantId);
  //     });
  //   });
  //   // return fireStore.collection(Collections.restaurants).doc(restaurantId).collection(Collections.menus).where(Menus.categoryId, isEqualTo: restaurantId).snapshots().map((event) => event.docs.length);
  // }

  Future<List<MenuModel>> getMenuFutureData() {
    return ref!.get().then((em) =>
        em.docs.map((e) {
          log(e);
          return e.data();
        }).toList());
  }

  static Stream<int> getTotalMenus({String? restaurantId}) {
    return fireStore.collection(Collections.restaurants).doc(restaurantId).collection(Collections.menus).snapshots().map((event) => event.docs.length);
  }

  Future<String> addMenuInfo(Map<String, dynamic> data, String restId, {File? profileImage}) async {
    var doc = await ref!.add(MenuModel.fromJson(data));
    ref!.doc(doc.id).update({CommonKeys.id: doc.id});

    if (profileImage != null) {
      ref!.doc(doc.id).update({Menus.image: await BaseService.getUploadedImageURL(profileImage, "$restId/${doc.id}")});
    }
    return doc.id;
  }

  Future<void> updateMenuInfo(Map<String, dynamic> data, String id, String restId, {File? profileImage}) async {
    await ref!.doc(id).update(data);
    if (profileImage != null) {
      ref!.doc(id).update({Menus.image: await BaseService.getUploadedImageURL(profileImage, '$restId')});
    }
    return;
  }
}
