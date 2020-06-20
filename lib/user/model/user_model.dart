import 'package:drop_poet/common/logger.dart';
import 'package:drop_poet/services/auth_service.dart';
import 'package:drop_poet/services/firestore_service.dart';
import 'package:drop_poet/user/data/user.dart';

class UserModel {
  static final _tag = "UserModel";

  final AuthService authService;
  final FirestoreService firestoreService;

  bool isLoggedIn = false;
  String userId;
  User user;

  UserModel(this.authService, this.firestoreService) {
    _fetchUserIfLoggedIn();
  }

  Future<void> _fetchUserIfLoggedIn() {
    authService.getUserStream().listen((user) {
      Logger.log(_tag, 'constructor - logged in: $user');
      if (user != null) {
        userId = user.uid;
        isLoggedIn = true;
        firestoreService.getUser(userId).then((user) {
          Logger.log(_tag, 'constructor - user ${user.username}');
          this.user = user;
        }).catchError((e) {
          Logger.log(_tag, e.toString());
        });
      }
    });
  }

  Future<void> signOut() {
    authService.logout();
    isLoggedIn = false;
    userId = null;
    user = null;
  }
}
