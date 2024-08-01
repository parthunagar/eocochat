import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fiberchat/Reasturant/main.dart';
import 'package:fiberchat/Reasturant/utils/model_keys.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

abstract class BaseService<T> {
  CollectionReference<T>? ref;

  BaseService({this.ref});

  Future<DocumentReference> addDocument(T data) async {
    var doc = await ref!.add(data);
    doc.update({'uid': doc.id});
    return doc;
  }

  Future<DocumentReference> addDocumentWithCustomId(String id, T data) async {
    var doc = ref!.doc(id);

    return await doc.set(data).then((value) {
      log('Added: $data');

      return doc;
    }).catchError((e) {
      log(e);
      throw e;
    });
  }

  Future<void> updateDocument(Map<String, dynamic> data, String? id) => ref!.doc(id).update(data);

  // Future<void> removeDocument(String id) => ref!.doc(id).delete();

  Future<void> removeDocument(String id) async {
    Future<QuerySnapshot> menus = ref!.doc(id).collection(Collections.menus).get();
    menus.then((value) {
      value.docs.forEach((element) {
        fireStore.collection(Collections.restaurants).doc(id).collection(Collections.menus).doc(element.id).delete().then((value) => print('Menu del.........Success..........'));
      });
    });

    Future<QuerySnapshot> categories = ref!.doc(id).collection(Collections.categories).get();
    categories.then((value) {
      value.docs.forEach((element) {
        ref!.doc(id).collection(Collections.categories).doc(element.id).delete().then((value) async {
          print('Category del.........Success..........');
        });
      });
    });

    await ref!.doc(id).delete();
  }

  Future<bool> isUserExist(String? email) async {
    Query query = ref!.limit(1).where('email', isEqualTo: email);
    var res = await query.get();

    if (res.docs.isNotEmpty) {
      return res.docs.length == 1;
    } else {
      return false;
    }
  }

  Future<Iterable> getList() async {
    var res = await ref!.get();
    Iterable it = res.docs;
    return it;
  }

  static Future<String> getUploadedImageURL(File image, String path) async {
    String fileName = path;
    Reference storageRef = _storage.ref().child("$path/$fileName");
    UploadTask uploadTask = storageRef.putFile(image);
    return await uploadTask.then((e) async {
      return await e.ref.getDownloadURL().then((value) {
        return value;
      });
    });
  }
}
