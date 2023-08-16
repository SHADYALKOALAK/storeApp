import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeonline/firebase/models/user_model.dart';

class UsersFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String table = 'Users';

  /// Create
  Future<bool> create(UserModel user) async {
    await _firestore
        .collection(table)
        .doc(user.id)
        .set(user.toJson())
        .catchError((onError) => false);

    return true;
  }

  Future<UserModel?> show(String email) async {
    try {
      var data = await _firestore
          .collection(table)
          .where('email', isEqualTo: email)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          )
          .get();

      if(data.docs.isNotEmpty) {
        return data.docs.first.data();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Read
  Stream<QuerySnapshot<UserModel>> read() async* {
    yield* _firestore
        .collection(table)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots();
  }

  /// Update
  Future<bool> update(UserModel user) async {
    await _firestore
        .collection(table)
        .doc(user.id)
        .update(user.toJson())
        .catchError((onError) => false);

    return true;
  }

  /// Delete
  Future<bool> delete(UserModel user) async {
    await _firestore
        .collection(table)
        .doc(user.id)
        .delete()
        .catchError((onError) => false);

    return true;
  }
}
