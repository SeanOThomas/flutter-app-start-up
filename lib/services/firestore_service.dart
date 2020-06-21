import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_poet/user/data/user.dart';

class FirestoreService {
  static final _tag = "FirestoreService";

  final Firestore _db = Firestore.instance;

  Future<User> getUser(String userId) async {
    DocumentSnapshot snap = await _db.collection("users").document(userId).get();
    return User.fromJson(snap.data);
  }

  Future<String> doesEmailExist(String email) async {
    QuerySnapshot snapshots = await _db.collection("users").where("email", isEqualTo: email).getDocuments();
    if (snapshots.documents.isNotEmpty) {
      return snapshots.documents[0].documentID;
    }
    return null;
  }

  Future<void> addUser(String uid, String email, String username) {
    return _db
        .collection("users")
        .document(uid)
        .setData({"email": email, "username": username, "created": Timestamp.now()});
  }

  Future<bool> isUsernameFree(String username) async {
    QuerySnapshot snapshots = await _db.collection("users").where("username", isEqualTo: username).getDocuments();
    return snapshots.documents.isEmpty;
  }
}
