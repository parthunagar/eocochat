import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/user_model.dart';
import 'package:qr_menu/services/base_service.dart';
import 'package:qr_menu/utils/model_keys.dart';

class UserService extends BaseService<UserModel> {
  UserService() {
    ref = fireStore.collection(Collections.user).withConverter<UserModel>(
      fromFirestore: (snapshot, options) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  Future<bool> isUserExist(String? email) async {
    Query query = ref!.limit(1).where('email', isEqualTo: email);
    var res = await query.get();

    return res.docs.length == 1;
  }

  Future<UserModel> userByEmail(String? email) async {
    return ref!.limit(1).where('email', isEqualTo: email).get().then((value) => value.docs.first.data());
  }

  Future<UserModel> getUser({String? email}) {
    return ref!.where("email", isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.length == 1) {
        return value.docs.first.data();
      } else {
        throw 'User Not found';
      }
    });
  }
}


