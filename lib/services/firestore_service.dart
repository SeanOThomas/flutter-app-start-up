import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_poet/user/data/user.dart';

class FirestoreService {
  static final _tag = "FirestoreService";

  final Firestore _db = Firestore.instance;

  Future<User> getUser(String userId) async {
    DocumentSnapshot snap = await _db.collection("users").document(userId).get();
    return User.fromJson(snap.data);
  }
}
